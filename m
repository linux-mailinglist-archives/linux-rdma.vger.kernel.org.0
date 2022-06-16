Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED47254DDDB
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Jun 2022 11:07:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359379AbiFPJHI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 16 Jun 2022 05:07:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359247AbiFPJHH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 16 Jun 2022 05:07:07 -0400
Received: from hr2.samba.org (hr2.samba.org [IPv6:2a01:4f8:192:486::2:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 185CC326CB
        for <linux-rdma@vger.kernel.org>; Thu, 16 Jun 2022 02:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
        s=42; h=From:Cc:To:Date:Message-ID;
        bh=UPabpRLuw/uxKsUO9YxASoSaOF33pPAgtHcQjeKbEFs=; b=39uKA8TYg1RSHtBNIm5WRUvB77
        oeQ30+IZ9v2VbXypqFwqC7PLbZgD1Zg4ygKfasE5rvGuzOzc9vpbC+ukExOc4L2iPpaPDY6b9vacN
        4coxcdI2oRGmKI+a+5W8v8mhJp+3EPcYexYoA/nZNua49Scymf3OgJ3wWrX9d2kovDlFkimchX4GH
        YutLHcFk8y5XTLz4Nx2Gpk6wLWGxrlKgv32gcQMbURc3Eg+DVCsEptUcrVrgDHs1+LaAv+TDYIKlt
        u2S63p8THwpLcbPwnm3Yblc8dF8cfiJ56mnw8SKJpSWrdeaiT7BEm7JujKLqZ2fH9u3LtcOUcFtrc
        Q9xZHefIoXvps6sPlNyoYtUffVGaXDOBa86xZ0leHLeQR2BGVPI0KSoHCWmjNqzWAbMl8rKaIbdtB
        G0Wf3CAx3mRdxZvwuuLpivzeg3Zr5zBWIw+Mlh6eH4GS3ZeueW+n6WIRMqshA11kWKWtvzEIm8H5M
        y06ctP+hG7ZoRD9RyCmMqgnZ;
Received: from [127.0.0.2] (localhost [127.0.0.1])
        by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__ECDSA_SECP256R1_SHA256__CHACHA20_POLY1305:256)
        (Exim)
        id 1o1lSy-0005S7-20; Thu, 16 Jun 2022 09:07:04 +0000
Message-ID: <ad060508-3cfd-8663-2d19-22c351f98ca1@samba.org>
Date:   Thu, 16 Jun 2022 11:07:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Content-Language: en-US
To:     Bernard Metzler <BMT@zurich.ibm.com>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Cheng Xu <chengyou@linux.alibaba.com>
References: <BYAPR15MB2631B0C5E27454FE2ECBAC2799AD9@BYAPR15MB2631.namprd15.prod.outlook.com>
From:   Stefan Metzmacher <metze@samba.org>
Subject: Re: [PATCH v2 00/14] rdma/siw: implement non-blocking connect
In-Reply-To: <BYAPR15MB2631B0C5E27454FE2ECBAC2799AD9@BYAPR15MB2631.namprd15.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Bernard,

> Hi Stefan, much appreciated! I think the erdma driver
> did a good job implementing something similar, but w/o
> the need to look into MPA v2 specifics, especially the
> extra handshake in RDMA mode.

As far as I see they introduce a dedicated
ERDMA_CM_WORK_CONNECTTIMEOUT and the timeouts
are:

 > +#define MPAREQ_TIMEOUT (HZ * 20)
 > +#define MPAREP_TIMEOUT (HZ * 10)
 > +#define CONNECT_TIMEOUT (HZ * 10)

If I read the code correct that would be 10 + 20 seconds
before a RDMA_CM_EVENT_ESTABLISHED must be posted.

I'm using just one timer (#define MPAREQ_TIMEOUT (HZ * 10)) that spans the tcp connect
as well as the MPA handshare.

I don't think we should care in what portion the time was spend
between tcp and mpa, what matters for the caller is the overall timeout
to get a valid connection. So I think a single timeout is better.

> Did you take care of the MPA v2 extended connection
> establishment stuff?

I'm not aware that I have touched (or had to care about) that at all here.

> I'll have a look asap, I am just down with a nice
> COVID infect. This to let you know I am not ignoring,
> but have another interesting experience which takes
> most of my time 😉. Will come back to it asap!

Get well soon!

Thanks!
metze
