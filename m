Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 095E47A74CA
	for <lists+linux-rdma@lfdr.de>; Wed, 20 Sep 2023 09:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233974AbjITHtO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 20 Sep 2023 03:49:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234061AbjITHss (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 20 Sep 2023 03:48:48 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20FA1114
        for <linux-rdma@vger.kernel.org>; Wed, 20 Sep 2023 00:47:57 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A071AC433CA;
        Wed, 20 Sep 2023 07:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695196077;
        bh=+E07z3F6Pthz8MP1Frxxbazd5C0kqDwa5tQ1wtpx5eE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YZk0BtCrCbdDgBEnGEaxUT79AK3QT0MQA1b8oDPrfOYIk6oKNeEbjZG2XF5J8qTUj
         yuTONEn1iPwbGRzf29MB+tJsIUwpSF1w7qjQuiC1ypxiAvSQc+yF6+WGF7QDTtiJ6R
         Xp8zHLo1IuxKgUAIXatw17Z84QkhODiri49EcI5uovOQoXOFDUjVDOOJBVTOlVBFpT
         2GjH0YUrGF2rknYR7MIRgoPwLKTBGlA5G+i+pefAjGyAq52ez9x3wz53ImWr08/1Fs
         IBUTF3j8BjThzEuKQ14xiHcj7Xez8gOqQzD9fFwFV21S4SLOwowfXRnYYO+gAX2Cty
         1gqzfasWkBrew==
Date:   Wed, 20 Sep 2023 10:47:53 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
Cc:     Zhu Yanjun <yanjun.zhu@linux.dev>,
        Zhu Yanjun <yanjun.zhu@intel.com>,
        "haris.iqbal@ionos.com" <haris.iqbal@ionos.com>,
        "jinpu.wang@ionos.com" <jinpu.wang@ionos.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH 1/1] RDMA/rtrs: Fix the problem of variable not
 initialized fully
Message-ID: <20230920074753.GJ4494@unreal>
References: <20230919020806.534183-1-yanjun.zhu@intel.com>
 <20230919081712.GD4494@unreal>
 <01d9dd18-3d63-fabb-33d4-0de528f15a9a@linux.dev>
 <20230919093028.GG4494@unreal>
 <d07d0b22-d932-dc01-1f33-c07932856fbc@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d07d0b22-d932-dc01-1f33-c07932856fbc@fujitsu.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Sep 20, 2023 at 02:16:20AM +0000, Zhijian Li (Fujitsu) wrote:
> 
> 
> On 19/09/2023 17:30, Leon Romanovsky wrote:
> > On Tue, Sep 19, 2023 at 04:26:54PM +0800, Zhu Yanjun wrote:
> >>
> >> 在 2023/9/19 16:17, Leon Romanovsky 写道:
> >>> On Tue, Sep 19, 2023 at 10:08:06AM +0800, Zhu Yanjun wrote:
> >>>> From: Zhu Yanjun <yanjun.zhu@linux.dev>
> >>>>
> >>>> No functionality change. The variable which is not initialized fully
> >>>> will introduce potential risks.
> >>> Are you sure about not being initialized?
> >>
> >> About this problem, I think we discussed it previously in RDMA maillist.
> >>
> >> And at that time, IIRC, you shared a link with me. The link is as below.
> >>
> >> https://www.ex-parrot.com/~chris/random/initialise.html
> >>
> >>  From what we discussed and the above link, I think it is not initialized
> >> fully.
> > 
> > I remember that discussion and it was about slightly different thing:
> > {} vs {0} in Linux kernel.
> 
> 
> Well, in my mind, I thought they are the same. see: https://www.gnu.org/software/gnu-c-manual/gnu-c-manual.html#Initializing-Structure-Members

It is GCC specific implementation, the original discussion was about C-standard.

Thanks
