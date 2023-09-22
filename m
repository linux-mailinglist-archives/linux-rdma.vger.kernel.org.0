Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A42E7AAF80
	for <lists+linux-rdma@lfdr.de>; Fri, 22 Sep 2023 12:30:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232498AbjIVKaF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 22 Sep 2023 06:30:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233355AbjIVKaD (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 22 Sep 2023 06:30:03 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CFBE195;
        Fri, 22 Sep 2023 03:29:56 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87E39C433C9;
        Fri, 22 Sep 2023 10:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695378596;
        bh=/i1zbZoU5NiY0diHT4erelvkPZqClSw6bwMm0Z9t+t8=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=IADJUGviHeBuvuTH9yNkK952Wx+KotbLb4IKe11tLF6OGjsTpcJtU/9jQ/B824Xhu
         lgcWVGiMsYgB5YJq9W/BdxtiD1xYtR5rm9QX4q2/z+nyq8KKN6V6xBGd0e9G+LnssH
         6EyEB/dK81Jz4+0JN6PTrreZu4tQUpZA7weSrr9XP0sKy+uraBJa80sykqa1q0Uwy0
         1c8Nm9RYjTCyr69bwWOMniICTYxAi49F2aUBnvYF2IUnqv5wHcA9JZ0LVYHmCjQfXZ
         Mf+kRkUX3Z/uVDlR8wIpuMRWrLJFZwEfj3HMsw7QVQakaZlvBdc/WRQFa8aswQAw6H
         K2x+Z4Lcy27bw==
From:   Leon Romanovsky <leon@kernel.org>
To:     Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Justin Stitt <justinstitt@google.com>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C20230921-strncpy-drivers-infiniband-hw-qib-qib=5Fi?=
 =?utf-8?q?ba7322-c-v1-1-373727763f5b=40google=2Ecom=3E?=
References: =?utf-8?q?=3C20230921-strncpy-drivers-infiniband-hw-qib-qib=5Fib?=
 =?utf-8?q?a7322-c-v1-1-373727763f5b=40google=2Ecom=3E?=
Subject: Re: [PATCH] IB/qib: replace deprecated strncpy
Message-Id: <169537859190.3339131.7912668348878588064.b4-ty@kernel.org>
Date:   Fri, 22 Sep 2023 13:29:51 +0300
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-a055d
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On Thu, 21 Sep 2023 07:58:48 +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings [1]
> and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> We know `txselect_list` is expected to be NUL-terminated based on its
> use in `param_get_string()`:
> | int param_get_string(char *buffer, const struct kernel_param *kp)
> | {
> | 	const struct kparam_string *kps = kp->str;
> | 	return scnprintf(buffer, PAGE_SIZE, "%s\n", kps->string);
> | }
> 
> [...]

Applied, thanks!

[1/1] IB/qib: replace deprecated strncpy
      https://git.kernel.org/rdma/rdma/c/cb7ab7854bc709

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
