Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 586EA738B76
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Jun 2023 18:36:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230497AbjFUQg3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 21 Jun 2023 12:36:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231751AbjFUQgM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 21 Jun 2023 12:36:12 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66DA32694;
        Wed, 21 Jun 2023 09:35:40 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0CCF521F4A;
        Wed, 21 Jun 2023 16:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1687365339; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+0Q2h3O0XuY1tWpBBSBUoHTehJTmmyJ4YcFxw2NRHdY=;
        b=srqJiyBYhbu7SckoBkoFzk+4wnCIhODnDodTObD+Ml9Ob+AaS2MQjMP/pAYz2rJyg0ZILy
        0smdUvz1ngDho9VTV0A3fKqYcbNixaMd9GsQTvMOPPwgjepzr/KaxTJzxi9dsXe2eSzV8Z
        mIKhBzhJssXFKkCmvvH4CvwcApSA/zo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1687365339;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+0Q2h3O0XuY1tWpBBSBUoHTehJTmmyJ4YcFxw2NRHdY=;
        b=rliaXNN14C05tbGb8lNANSl0nNHTo0sOWP2HhLugRbjx+4A7i2d+v+nsoedWrziymQGOof
        +DTRbj+WfUCKKKCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EFC1A133E6;
        Wed, 21 Jun 2023 16:35:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id AQWBOtomk2R+QwAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 21 Jun 2023 16:35:38 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 8DF9AA075D; Wed, 21 Jun 2023 18:35:38 +0200 (CEST)
Date:   Wed, 21 Jun 2023 18:35:38 +0200
From:   Jan Kara <jack@suse.cz>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/79] qib_fs: switch to new ctime accessors
Message-ID: <20230621163538.2y6s6g67byni7qhk@quack3>
References: <20230621144507.55591-1-jlayton@kernel.org>
 <20230621144735.55953-1-jlayton@kernel.org>
 <20230621144735.55953-4-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230621144735.55953-4-jlayton@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed 21-06-23 10:45:18, Jeff Layton wrote:
> In later patches, we're going to change how the ctime.tv_nsec field is
> utilized. Switch to using accessor functions instead of raw accesses of
> inode->i_ctime.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  drivers/infiniband/hw/qib/qib_fs.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/qib/qib_fs.c b/drivers/infiniband/hw/qib/qib_fs.c
> index a973905afd13..db008f2884e4 100644
> --- a/drivers/infiniband/hw/qib/qib_fs.c
> +++ b/drivers/infiniband/hw/qib/qib_fs.c
> @@ -64,9 +64,7 @@ static int qibfs_mknod(struct inode *dir, struct dentry *dentry,
>  	inode->i_uid = GLOBAL_ROOT_UID;
>  	inode->i_gid = GLOBAL_ROOT_GID;
>  	inode->i_blocks = 0;
> -	inode->i_atime = current_time(inode);
> -	inode->i_mtime = inode->i_atime;
> -	inode->i_ctime = inode->i_atime;
> +	inode->i_atime = inode->i_mtime = inode_ctime_set_current(inode);
>  	inode->i_private = data;
>  	if (S_ISDIR(mode)) {
>  		inode->i_op = &simple_dir_inode_operations;
> -- 
> 2.41.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
