Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C43E178EE0A
	for <lists+linux-rdma@lfdr.de>; Thu, 31 Aug 2023 15:04:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242601AbjHaNET (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 31 Aug 2023 09:04:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232184AbjHaNES (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 31 Aug 2023 09:04:18 -0400
Received: from mail.bsc.es (mao.bsc.es [84.88.52.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EE01BC
        for <linux-rdma@vger.kernel.org>; Thu, 31 Aug 2023 06:04:14 -0700 (PDT)
Received: from hop.home (2.152.176.31.dyn.user.ono.com [2.152.176.31])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.bsc.es (Postfix) with ESMTPSA id E45634061881;
        Thu, 31 Aug 2023 15:04:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsc.es; s=20191012;
        t=1693487052;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NnxB0GUvkZQaEbLDuuy5LWX0sefRL/blbYcvf0bXh7s=;
        b=f6WE9ggQnOdQP4d/FtvfJWaQOUKygusFkwmvMJzewgouTwG/Ycr8HotJ9Z5cMo8/m4nFLS
        mUus0HXaTk80YUIbzPw3dII2+d8BHs6IPY1foYOkhwkBIcabDM7kZegj14s7OC7Exn3F0s
        t5/G4HZGhivBfmime069n7t3AIZ6EGDx2ZPs251UDT3K9uYyHkp4kN4RcJvv6aEndFXI5+
        kkmTDtHWAiu4E9ACGi/UIoIxtIzyv8o+mRQJPlYwK0uR6/27NjfR6X4QtZVKavR3gQJMtt
        7Igck7LDiDsANeSfJHzSReMqhUga6DljzAI+0ozCl0ou2wLP0Awhxs1auKrFQQ==
Date:   Thu, 31 Aug 2023 15:04:10 +0200
From:   Rodrigo Arias <rodrigo.arias@bsc.es>
To:     Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc:     linux-rdma@vger.kernel.org,
        "Koch, Kerry" <kerry.a.koch@cornelisnetworks.com>,
        "Luick, Dean" <dean.luick@cornelisnetworks.com>,
        "Cunningham, Brendan" <brendan.cunningham@cornelisnetworks.com>,
        "Miller, Doug" <Doug.Miller@cornelisnetworks.com>,
        Ehab Ababneh <ehab.ababneh@cornelisnetworks.com>
Subject: Re: [bug-report] Oops at hfi1_ipoib_send + hfi1_ipoib_sdma_complete
 IRQ
Message-ID: <ZPCPynn0HDxSLBzn@hop.home>
References: <ZO8dWSh5Y9D8FZG9@hop.home>
 <5868fabe-a45a-3960-aa4b-d81cff8ef6ec@cornelisnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <5868fabe-a45a-3960-aa4b-d81cff8ef6ec@cornelisnetworks.com>
X-Spamd-Result: default: False [-8.38 / 15.00];
         ARC_NA(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         DKIM_SIGNED(0.00)[bsc.es:s=20191012];
         RCPT_COUNT_SEVEN(0.00)[7];
         NEURAL_HAM(-0.00)[-1.000];
         WHITELIST_SENDER_DOMAIN(-5.00)[bsc.es];
         RCVD_COUNT_ZERO(0.00)[0];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         ASN(0.00)[asn:6739, ipnet:2.152.0.0/16, country:ES];
         BAYES_HAM(-3.28)[97.56%]
X-Copyrighted-Material: Please visit http://www.bsc.es/disclaimer
X-Rspamd-Server: opsmail02.bsc.es
X-Rspamd-Queue-Id: E45634061881
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Dennis,

>Thanks for the bug report. We will look into this and see what we can 
>come up with.

Thank you :-)

>I've added some of my engineers to CC. Do you happen to have a 
>crashdump perchance that you could upload to us?

I don't have, but I will try to reproduce it again and get one.

I was trying to use a simpler using iperf3 but no luck so far. Changing 
the network from Ethernet to IPoIB in ceph is complicated.

Rodrigo.
