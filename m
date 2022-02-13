Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BAC34B3B34
	for <lists+linux-rdma@lfdr.de>; Sun, 13 Feb 2022 12:57:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235754AbiBML5D (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 13 Feb 2022 06:57:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235745AbiBML46 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 13 Feb 2022 06:56:58 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E5C05B8AC;
        Sun, 13 Feb 2022 03:56:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 33E1EB80AE8;
        Sun, 13 Feb 2022 11:56:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 050D6C004E1;
        Sun, 13 Feb 2022 11:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644753410;
        bh=uMBE7nklEtwOQeHfA15TM5pA68TW4OU2vBGHyA6pUu0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SmWWtNpkrLLRbe7yla5PPtHw9zKbtmS4IWI5sKgY6ECuFnr+MV+uEUyIJr9oBtnM1
         fdeuwQ2U8r6anWKEyF3X/P00YjypfaRPn0+abN3i8tAo5fYE7+J2wzI8NmoGdq1A8+
         DCagidpp6GYBOhf8G1PFEkZX7VMpM1mmT4G01xTrpwU7DnaMEjzlPCcDMzZ7RXmBE/
         Fy44UnbavzBbgj3ZkQldpcvyHI/8LZyRt7PuFJerKN2sWNnfgT3+eRVsyw+gWq4sQm
         ajPz+dAr+kiZZg6/cxrSFhPJQjsz5DIAsHlazTAlkcbUoEtOruJOnoMRb4W7eEYR+e
         ryn7/G7gp0jgw==
Date:   Sun, 13 Feb 2022 13:56:45 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     =?iso-8859-1?Q?H=E5kon?= Bugge <haakon.bugge@oracle.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH for-rc v2] IB/cma: Allow XRG INI QPs to set their local
 ACK timeout
Message-ID: <Ygjx/XokZw/ZMDuT@unreal>
References: <1644421175-31943-1-git-send-email-haakon.bugge@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1644421175-31943-1-git-send-email-haakon.bugge@oracle.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Feb 09, 2022 at 04:39:35PM +0100, Håkon Bugge wrote:
> XRC INI QPs should be able to adjust their local ACK timeout.
> 
> Fixes: 2c1619edef61 ("IB/cma: Define option to set ack timeout and pack tos_set")
> Signed-off-by: Håkon Bugge <haakon.bugge@oracle.com>
> Suggested-by: Avneesh Pant <avneesh.pant@oracle.com>
> 
> ---
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
