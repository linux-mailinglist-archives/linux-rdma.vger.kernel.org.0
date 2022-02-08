Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFB1B4AD88E
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Feb 2022 14:15:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348548AbiBHMHU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 8 Feb 2022 07:07:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235596AbiBHMHS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 8 Feb 2022 07:07:18 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD49FC03FECE
        for <linux-rdma@vger.kernel.org>; Tue,  8 Feb 2022 04:07:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 45489B81AA0
        for <linux-rdma@vger.kernel.org>; Tue,  8 Feb 2022 12:07:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6A4BC004E1;
        Tue,  8 Feb 2022 12:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644322035;
        bh=qmJz+Q8Bq6ckiNElce0iYeeczOdkQCDyzdjp57JRs3g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XIJe2d8Bm1cGCMrS3m13UrU/3qe7HlBMyjH8BzEedPrq6S3v3OHd8tOTENWPNpRRr
         g1E3fwPtdQ9yblbvgFaXoxDAHy0uO2rUp7LWhUE7Qy+uWxw1jZsjJf2LSvh0HkNmud
         +B7ZWl56CzDq0SVTJ8306uINnK2pVFRL7zKyHl7Q5UPiip8cc3o3OWzTETXI4iQiQQ
         HTUTWle8fG/hLXSghBjfm6Oz7s0GA1sbQCAodP9utMuwC7E8it+0VdUfAwCAblxGpK
         szJkhOQ2tH9lO1Ewn29JBv5XSvlZNGy1p1uI20WSP4FxZ9rny00Qgw1H3089A6ItXa
         z1aICtJhkWdxQ==
Date:   Tue, 8 Feb 2022 14:07:08 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Haakon Bugge <haakon.bugge@oracle.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>
Subject: Re: Seeking clarification on the XRC Annex wrt. a TGT QP having a SQ
Message-ID: <YgJc7DQ8T14do6WK@unreal>
References: <6FD25F7D-6F5A-4990-A179-5ED213001BB7@oracle.com>
 <YgFsDXH5XdEBOT/O@unreal>
 <099658DB-B526-481A-B3BA-6F95BA74350C@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <099658DB-B526-481A-B3BA-6F95BA74350C@oracle.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Feb 08, 2022 at 10:53:15AM +0000, Haakon Bugge wrote:
> 
> 
> > On 7 Feb 2022, at 19:59, Leon Romanovsky <leon@kernel.org> wrote:
> > 
> > On Mon, Feb 07, 2022 at 02:55:35PM +0000, Haakon Bugge wrote:
> >> Hey,
> >> 
> >> 
> >> I have a question to XRC TGT QPs and whether they do have a set of requestor resources or not.
> >> 
> >> 
> >> The XRC Annex (March 2, 2009 Revision 1.0) (*1) boldly states:
> >> 
> >> 	XRC TGT QPs are similar to RD EECs but do not have a requester side.
> >> 
> >> 
> >> Nevertheless, in Table 9, page 36, it is stated that "Local ACK Timeout" and "SQ PSN" are required attributes during an RTR -> RTS transition for an XRC Target QP. This seems to be an incorrect requirement, subject to the XRC Target QP not having a send queue?
> >> 
> >> Further, looking at a vendor's creation of an XRC TGT QP, we see:
> >> 
> >> 	MLX5_SET(qpc, qpc, no_sq, 1);
> >> 
> >> in the function create_xrc_tgt().
> >> 
> >> If the interpretation that an XRC TGT does _not_ have a send queue is correct, we cannot simply remove "Local ACK Timeout" and "SQ PSN" as mandatory attributes during the state transition, because that will break all current software. Is it an idea to move those to optional attributes in the qp_state_table[]? Then remove the IB_QPT_XRC_TGT label in cm_init_qp_rts_attr()?
> > 
> > I think that your interpretation of spec is correct, but why do you want
> > to remove these attributes? The device ignores them anyway.
> 
> :-)
> 
> Or, rephrasing your question, why have these attributes as mandatory? The device ignores them anyway ;-)

I can only guess. The spec is written by HW people, together with
statement than XRC TGT QP same as RC, most likely, the decision was
to take RC block and copy/paste for XRC TGT.

Thanks

> 
> To me, it is confusing. For example, in rdma_set_min_rnr_timer(), the test for XRC TGT is correct, since an XRG INI QP does not have any responder part. But this is then inconsistent with other parts of CM/CMA.



> 
> 
> Thxs, Håkon
> 
> > Thanks
> > 
> >> 
> >> 
> >> Thxs, Håkon
> >> 
> >> *1: IBTA Spec Release 1.6 is equal to the XRC Annex in this respect
> 
