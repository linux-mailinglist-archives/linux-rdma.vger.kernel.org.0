Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76D997BD30B
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Oct 2023 08:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345152AbjJIGJV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 9 Oct 2023 02:09:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345128AbjJIGJU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 9 Oct 2023 02:09:20 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 983FF9E
        for <linux-rdma@vger.kernel.org>; Sun,  8 Oct 2023 23:09:19 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B13D7C433C8;
        Mon,  9 Oct 2023 06:09:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696831759;
        bh=2nq3iSI5WJvmj36Pf94kUaj0+f4wumnnvSun23asnXg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fUM+Grsp3qiwqDktgHfvdY3/hZuaLNilc0lcpIHbTgg2vb+5+Twww/4m1gysgl5x5
         +wl2Ugp+4o2QPh6QX9jm0CSFWPj0vlPy+0O1DynhljFivZxouyhi2PyN7SBYp7gofj
         LGVgMH/+EMIoQk+Oy2MHfKCqDHn1TgrhcKZ9zy7BJ2nknLjYATLruvUCJwnNaIcIZZ
         HMb6Zv6JtHpiqZ+Pj7DwkgOnV2h1ZMr817q2cKOfz/In52yCRzdrce44KRCBwfiTps
         pVu9izy51/HIv36PG2GUQd6AuD9+W4OOZzI6n7BaT4Xc6rdGKTKfGxZkOIxZvvlYFT
         2csn7YtsfTZSw==
Date:   Mon, 9 Oct 2023 09:09:15 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Selvin Xavier <selvin.xavier@broadcom.com>
Cc:     jgg@ziepe.ca, linux-rdma@vger.kernel.org,
        andrew.gospodarek@broadcom.com,
        Chandramohan Akula <chandramohan.akula@broadcom.com>
Subject: Re: [PATCH for-next 1/3] RDMA/bnxt_re: Update HW interface headers
Message-ID: <20231009060915.GA5042@unreal>
References: <1696483889-17427-1-git-send-email-selvin.xavier@broadcom.com>
 <1696483889-17427-2-git-send-email-selvin.xavier@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1696483889-17427-2-git-send-email-selvin.xavier@broadcom.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Oct 04, 2023 at 10:31:27PM -0700, Selvin Xavier wrote:
> From: Chandramohan Akula <chandramohan.akula@broadcom.com>
> 
> Updating the HW structures for the affiliated event and error
> reporting. Newly added interface structures will be used in the
> followup patch.
> 
> Signed-off-by: Chandramohan Akula <chandramohan.akula@broadcom.com>
> Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
> ---
>  drivers/infiniband/hw/bnxt_re/roce_hsi.h | 62 ++++++++++++++++++++++++++++++++
>  1 file changed, 62 insertions(+)

<...>

> +	#define CREQ_QP_ERROR_NOTIFICATION_REQ_ERR_STATE_REASON_LAST \
> +			CREQ_QP_ERROR_NOTIFICATION_REQ_ERR_STATE_REASON_REQ_RETX_SETUP_ERROR
>  	__le32	xid;

<...>

> +	#define CREQ_QP_ERROR_NOTIFICATION_RES_ERR_STATE_REASON_LAST \
> +			CREQ_QP_ERROR_NOTIFICATION_RES_ERR_STATE_REASON_RES_PSN_NOT_FOUND

These defines are not used.

Thanks

>  	__le16	sq_cons_idx;
>  	__le16	rq_cons_idx;
>  };
> -- 
> 2.5.5
> 


