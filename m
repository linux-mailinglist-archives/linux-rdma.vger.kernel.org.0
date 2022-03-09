Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D99C74D2C20
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Mar 2022 10:35:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231373AbiCIJfz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 9 Mar 2022 04:35:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232146AbiCIJft (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 9 Mar 2022 04:35:49 -0500
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57EBF85955;
        Wed,  9 Mar 2022 01:34:50 -0800 (PST)
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1646818488;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4Li/atw8t4VHrlTtZr7lVd54CxfuY0zgPh9pM5418Gw=;
        b=Pdnrk6qwBRHlXgjDlB+kplmOEV1Q3EpIVprYkuLXjYsuNxMs4Sj2qdWeeSnBFDLMInRJDK
        gv1tdrWuovr/cnnpl7YPJZDEFlNG5XSbGuJ4632b8iilQtsPG3Jags+ib1keAfIPoOE+Ij
        SWbKI6QtI8pj1woS2lJN20ORZnNd1to=
Date:   Wed, 09 Mar 2022 09:34:47 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   "Yajun Deng" <yajun.deng@linux.dev>
Message-ID: <9e6973cfbca0ef70bfd57f499a7f5397@linux.dev>
Subject: Re: [PATCH for-next 0/9] RDMA: get rid of create_user_ah
To:     "Leon Romanovsky" <leonro@nvidia.com>
Cc:     jgg@nvidia.com, selvin.xavier@broadcom.com, galpress@amazon.com,
        sleybo@amazon.com, liangwenpeng@huawei.com, liweihang@huawei.com,
        mustafa.ismail@intel.com, shiraz.saleem@intel.com,
        dennis.dalessandro@cornelisnetworks.com,
        mike.marciniszyn@cornelisnetworks.com, zyjzyj2000@gmail.com,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <Yihxh3HdEqu3B2w9@unreal>
References: <Yihxh3HdEqu3B2w9@unreal>
 <20220308143428.3401170-1-yajun.deng@linux.dev>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Thank you for the tip.=0A -- Yajun=0A=0AMarch 9, 2022 5:21 PM, "Leon Roma=
novsky" <leonro@nvidia.com> wrote:=0A=0A> On Tue, Mar 08, 2022 at 10:34:2=
8PM +0800, Yajun Deng wrote:=0A> =0A>> The two members create_user_ah and=
 create_ah in struct ib_device_ops=0A>> are very similar. we can use crea=
te_ah for all case. so get rid of=0A>> create_user_ah.=0A> =0A> 1. Please=
 read commit message and content of commit 676a80adba01=0A> ("RDMA: Remov=
e AH from uverbs_cmd_mask") that added that .create_user_ah()=0A> callbac=
k.=0A> 2. You should send patches as a series that is threaded and not as=
=0A> stand-alone patches.=0A> =0A> Thanks
