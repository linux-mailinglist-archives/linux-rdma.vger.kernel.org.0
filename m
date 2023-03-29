Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1577A6CF212
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Mar 2023 20:22:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229453AbjC2SWe (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 29 Mar 2023 14:22:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjC2SWd (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 29 Mar 2023 14:22:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24B0D49D5
        for <linux-rdma@vger.kernel.org>; Wed, 29 Mar 2023 11:22:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B51A161DE6
        for <linux-rdma@vger.kernel.org>; Wed, 29 Mar 2023 18:22:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B6F9C433D2;
        Wed, 29 Mar 2023 18:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680114152;
        bh=8bP6ih0JJYB/HdvxjzRuxElwEt9ZZGJzaYYrBz9tlnw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DurzSAVU/Ea32n3KW7/29RSraREJBr/dOLV5MfbNpQMpyDJ0M8aNCFvf7NJefDv8a
         u7ZuDyX+DhxGEMldQIoA2f44Bmdn001YM4JTkvwQ1p8UDHXQbfZk9QsINvzVq49JeL
         cNsRgZ0A4k+q/FnDMHp8N9C9cHCpXICDYrfGMQq+R+J3zIbya230vO6upMOvnvwk+H
         Yy1bN8cRiVi+gc1IsEmx45K0JDXWeKnbcFwNICHar9lTwLa32KNMYvf4QsHGVLfkYV
         xSmuNwWSIx4k9gmSU+XnPhUSRT1wGl6IejUhJOJF19k6+81GjSJtc/z2OMwey73h6a
         WhKVqHXj/y00A==
Date:   Wed, 29 Mar 2023 21:22:27 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Dan Carpenter <error27@gmail.com>
Cc:     rpearsonhpe@gmail.com, linux-rdma@vger.kernel.org
Subject: Re: [bug report] RDMA/rxe: Rewrite rxe_task.c
Message-ID: <20230329182227.GY831478@unreal>
References: <480b32b6-0f1c-4646-9ecc-e0760004cd24@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <480b32b6-0f1c-4646-9ecc-e0760004cd24@kili.mountain>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Mar 29, 2023 at 09:27:26AM +0300, Dan Carpenter wrote:
> Hello Bob Pearson,
> 
> The patch d94671632572: "RDMA/rxe: Rewrite rxe_task.c" from Mar 4,
> 2023, leads to the following Smatch static checker warning:
> 
> 	drivers/infiniband/sw/rxe/rxe_task.c:24 __reserve_if_idle()
> 	warn: bitwise AND condition is false here

Fix:
https://lore.kernel.org/all/1a6376525c40454282a14ab659de0b17b02fe523.1680113901.git.leon@kernel.org

Thanks
