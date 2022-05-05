Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F1CC51BFCA
	for <lists+linux-rdma@lfdr.de>; Thu,  5 May 2022 14:48:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242840AbiEEMwG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 5 May 2022 08:52:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377697AbiEEMwF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 5 May 2022 08:52:05 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C9CC55489;
        Thu,  5 May 2022 05:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9/4Kg9VoiU/sUPa2yiFYb5rxD+E8WeBJfA29l8Jo62M=; b=KKZXVuNHcAPhVObiZr8RLA10PM
        x4pEB1jnO285NQgmoiRZfCCjMZooMWN7pzy9XibHRbax77gNKWWVzQCUJ8H33UiUS22SKIM115Qen
        jRKYeeelpXFgf6r8ZkRUbctC1YSjiuegkgPWGm1qnNOIvQ/oHZn7DmRTXZ5LC2pHz42/0L5fGFL/C
        GdnA2CktGfLOAyguPj6wGqnU8tVvNxJCKIms2TDHOrSxDs5zca+RNSbxmBbtLD5v2emdcsapk32Ar
        QWd/BTvnuFzfCpKKoUzSBkZqM8e4HzXNBeWYhXFU1/UDQ5ZaaSA4PHm2Ycz36madYRNc4YwQbqlK+
        r6nekriQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nmau4-00FsNQ-Se; Thu, 05 May 2022 12:48:20 +0000
Date:   Thu, 5 May 2022 05:48:20 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Bernard Metzler <BMT@zurich.ibm.com>
Cc:     Cheng Xu <chengyou@linux.alibaba.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Pankaj Raghav <pankydev8@gmail.com>,
        Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: siw_cm.c:255 siw_cep_put+0x125/0x130 kernel warning while
 testing blktests srp/002 v5.17-rc7
Message-ID: <YnPHlJWhlCbXdifi@bombadil.infradead.org>
References: <BYAPR15MB2631988B13EE2E336FD2ED4E99F29@BYAPR15MB2631.namprd15.prod.outlook.com>
 <1ec3f1d2-887d-f66c-6221-6319afc4a3e9@linux.alibaba.com>
 <YnLkxglbU157KkNK@bombadil.infradead.org>
 <b85c6425-6840-e01f-108b-c8ab03578731@linux.alibaba.com>
 <BYAPR15MB2631A0A967BF02C93BF0E45C99C29@BYAPR15MB2631.namprd15.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR15MB2631A0A967BF02C93BF0E45C99C29@BYAPR15MB2631.namprd15.prod.outlook.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, May 05, 2022 at 11:42:55AM +0000, Bernard Metzler wrote:
> 
> > -----Original Message-----
> > >
> > > *poke*
> > >
> > > Would be good to get a fix merged. And if a patch is posted does this
> > > need to go to stable?
> > >
> > >    Luis
> > 
> > The patch has been accepted and merged to for-rc, see:
> > 
> > INVALID URI REMOVED
> > 3A__lore.kernel.org_all_d528d83466c44687f3872eadcb8c184528b2e2d4.1650526
> > 554.git.chengyou-40linux.alibaba.com_T_&d=DwICaQ&c=jf_iaSHvJObTbx-
> > siA1ZOg&r=2TaYXQ0T-r8ZO1PP1alNwU_QJcRRLfmYTAgd3QCvqSc&m=gj2AyKoOM_k9fYF-
> > _XQ4HcYw_viOIwl6lDNPHqp7L1y2OiVRWvZkTFGFHSSZInor&s=P_HaXIXt9mBbCeBNBLsWe
> > RTz5hvnUGUvObzs8lowzCM&e=
> > 
> > I think this patch need not be merged back to stable, because the issue
> > is not a functional problem, but only produce a WARN in dmesg.
> > 
> > Thanks,
> > Cheng Xu
> 
> I agree. It does not fix a memory leak or some such.

If the warning triggers on older kernels it means testing using this
driver will fail and those tests will be skipped. In this case the
test srp/002 would be skipped unless this is fixed to not trigger
a kernel warning.

  Luis
