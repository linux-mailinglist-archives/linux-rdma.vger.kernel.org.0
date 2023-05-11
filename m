Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0808A6FEB50
	for <lists+linux-rdma@lfdr.de>; Thu, 11 May 2023 07:42:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231183AbjEKFmv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 11 May 2023 01:42:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjEKFmu (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 11 May 2023 01:42:50 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E677E26A8;
        Wed, 10 May 2023 22:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3tt65IPvL25utgB/BrnwIGIDJlkpRnSh4O1Dkc9Fq28=; b=gYnAPhgnMOpNp4Z8f5gKm468RZ
        Zs6/Nk/mrEr2RUEOrPARIwcXZbj/7r9fER555WTxnGyH5CXYfaL32JNLK/OlOUOmX6Y1NwPzNqoNh
        by85kFktbQcOvAldc1zfB8r1cJNb91mNTp+JvqfsjUYjy3acMbt0XiY9VjTAul5cfm1MD+dbaUXH9
        Gf61NgZQRquRVU+gnXtElpd5SLzF3IgjZCSSQmV2OhLDcseNVOFlIfrUQbZSMcybOFow7wwbLPDcs
        morBPBC/ZUTQCo3vQ2p8jTTBfB9NoE4wG6Fqssdsb7IdUKil85QEpY3Wyi7cTs7Q12mZK2oVs8Uyn
        /YmNHDaw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pwz4W-001chr-0A;
        Thu, 11 May 2023 05:42:36 +0000
Date:   Thu, 11 May 2023 06:42:36 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     ye.xingchen@zte.com.cn
Cc:     jgg@ziepe.ca, leon@kernel.org, jiangjian@cdjrlc.com,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RDMA/core: Use fdget() and fdput()
Message-ID: <20230511054236.GJ3390869@ZenIV>
References: <202305051133576690069@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202305051133576690069@zte.com.cn>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, May 05, 2023 at 11:33:57AM +0800, ye.xingchen@zte.com.cn wrote:
> From: Ye Xingchen <ye.xingchen@zte.com.cn>
> 
> convert the fget()/fput() uses to fdget()/fdput().

NAK on the entire series.  *IF* you do that kind of replacements,
you need to understand what you are doing; it's not "fdget() is
like fget(), only better; using it will improve things".

	If that comes from seeing my patch series doing fget() to
fdget() conversions, you might consider the possibility that
I *do* know how to use grep.  And that there might be some
objective difference between the instances that had been changed
and the one that had been left alone.  You could try to figure it
out.  Or look through the list archives.  Or ask...

	Al, more than slightly offended by the implications ;-/
