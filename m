Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF4C74AC927
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Feb 2022 20:04:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234339AbiBGTEg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 7 Feb 2022 14:04:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235259AbiBGS7d (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 7 Feb 2022 13:59:33 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 320EFC0401DC
        for <linux-rdma@vger.kernel.org>; Mon,  7 Feb 2022 10:59:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CB1506140B
        for <linux-rdma@vger.kernel.org>; Mon,  7 Feb 2022 18:59:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8369C004E1;
        Mon,  7 Feb 2022 18:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644260371;
        bh=RmTxjp99+NjphdsudgH8TZlEqiqYEHgixPDhNS6WpRE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GXbebgB9B2SAniQE3YTfacxpVp0opobUFXwnlcrFLBmENl877tuNPvKcd3GosX6f3
         cBzYtpvKDqCUny4gtRBY3uE1VdtVvusbJ1qv3CJXAMtZXlL7gTiLyGWYG3QnhJjr9K
         VP4m8hBpe2f7qizN3sWbnaa7ykTyW62JiZpJkn3s6mmj5d9YH8ND/ObeSibebyyoJ8
         05VBS9zKoTj9f79P8dH4IyXqQXq4kTdPMTvZCmwOxbO0otRTclMqmTUopsw57gryrc
         a8Y8hQyBwMLA1+ezxRn/YMonWjbRonOAVEgWlLZ+4Xrwek2tVpby7p4E91CiwRsRtR
         WvnR6OL5oFV/g==
Date:   Mon, 7 Feb 2022 20:59:25 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Haakon Bugge <haakon.bugge@oracle.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>
Subject: Re: Seeking clarification on the XRC Annex wrt. a TGT QP having a SQ
Message-ID: <YgFsDXH5XdEBOT/O@unreal>
References: <6FD25F7D-6F5A-4990-A179-5ED213001BB7@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6FD25F7D-6F5A-4990-A179-5ED213001BB7@oracle.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Feb 07, 2022 at 02:55:35PM +0000, Haakon Bugge wrote:
> Hey,
> 
> 
> I have a question to XRC TGT QPs and whether they do have a set of requestor resources or not.
> 
> 
> The XRC Annex (March 2, 2009 Revision 1.0) (*1) boldly states:
> 
> 	XRC TGT QPs are similar to RD EECs but do not have a requester side.
> 
> 
> Nevertheless, in Table 9, page 36, it is stated that "Local ACK Timeout" and "SQ PSN" are required attributes during an RTR -> RTS transition for an XRC Target QP. This seems to be an incorrect requirement, subject to the XRC Target QP not having a send queue?
> 
> Further, looking at a vendor's creation of an XRC TGT QP, we see:
> 
> 	MLX5_SET(qpc, qpc, no_sq, 1);
> 
> in the function create_xrc_tgt().
> 
> If the interpretation that an XRC TGT does _not_ have a send queue is correct, we cannot simply remove "Local ACK Timeout" and "SQ PSN" as mandatory attributes during the state transition, because that will break all current software. Is it an idea to move those to optional attributes in the qp_state_table[]? Then remove the IB_QPT_XRC_TGT label in cm_init_qp_rts_attr()?

I think that your interpretation of spec is correct, but why do you want
to remove these attributes? The device ignores them anyway.

Thanks

> 
> 
> Thxs, Håkon
> 
> *1: IBTA Spec Release 1.6 is equal to the XRC Annex in this respect
> 
> 
