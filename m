Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1359666B0DD
	for <lists+linux-rdma@lfdr.de>; Sun, 15 Jan 2023 13:09:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbjAOMJZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 15 Jan 2023 07:09:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbjAOMJY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 15 Jan 2023 07:09:24 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9315BCDFB;
        Sun, 15 Jan 2023 04:09:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2211760C97;
        Sun, 15 Jan 2023 12:09:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0354C433D2;
        Sun, 15 Jan 2023 12:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673784562;
        bh=lUxAxMc9+2hSdJcDN+MqbxKx0/XB9tFQG3YcYX7tx8Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q63pLgXyE83CtcneiswTFzKDYQMjjcv7P3d5czAMP7hKwkeq0/rtCSOB102dP+AFI
         opkpp79Gi4aqYuLsoCDxufCt1vRPLtazbgJIuUqVwGFbr4IvoD4LD1Nwc27Ya8Dts5
         9vPYvLo1tOGkHF/IqvqUQH4iDHTQwntmb+AjRnzf4Atvs/9JAy1xK6S2gLIMZloLlP
         W+c80/Y5JtTt/6weE6a73o5Biw5m2NgqGfhP6Eu+6pKkuJMWJohi/dHlzgfEdikuf0
         Z/ZkIjJdCTpqQCQPbkjzGc8ZaIklDNR4jgMqwNdZDH0rV1KsE3vzBJcaQRSf2qpl9w
         JqtWixhKOoygA==
Date:   Sun, 15 Jan 2023 14:09:17 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Zhu Yanjun <yanjun.zhu@linux.dev>
Cc:     Jia-Ju Bai <baijiaju1990@gmail.com>, zyjzyj2000@gmail.com,
        jgg@ziepe.ca, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, TOTE Robot <oslab@tsinghua.edu.cn>
Subject: Re: [PATCH] infiniband: sw: rxe: Add NULL checks for qp->resp.mr
Message-ID: <Y8Ps7UgTUuNx/+Qz@unreal>
References: <20230113023527.728725-1-baijiaju1990@gmail.com>
 <ec0e983b-15fb-e43f-90e2-d4f79d27298a@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ec0e983b-15fb-e43f-90e2-d4f79d27298a@linux.dev>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jan 13, 2023 at 03:53:46PM +0800, Zhu Yanjun wrote:
> 在 2023/1/13 10:35, Jia-Ju Bai 写道:
> > In a previous commit 3282a549cf9b, qp->resp.mr could be NULL. Moreover,
> > in many functions, qp->resp.mr is checked before its dereferences.
> > However, in some functions, this variable is not checked, and thus NULL
> > checks should be added.
> 
> IMO， we should analyze the code snippet one by one.
> And it is not good to add "NULL check" without futher investigations.

+1
