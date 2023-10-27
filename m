Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 401497DA3A6
	for <lists+linux-rdma@lfdr.de>; Sat, 28 Oct 2023 00:40:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232827AbjJ0Wkp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 27 Oct 2023 18:40:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbjJ0Wko (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 27 Oct 2023 18:40:44 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D9C2D4A;
        Fri, 27 Oct 2023 15:40:42 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08947C433C8;
        Fri, 27 Oct 2023 22:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698446441;
        bh=2rCIRtKFM+3RMPf0ZVAQKOeUDSTXWIOHQEyehpzPDsk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=IzrjaEBEkG0Xr84XrZyxlM92yU5kvrfPjNlirqcNGfPwVB8TrAG9V8DgOvpXBR57R
         UDRhz4p0tOe9MTFTUoRPkTnzuOnNWCDJtWj2+6RKOz1LLf9Pt0DDDv/q839q+9rBnd
         eSTMvp7fDmb0SVCmVQwSfMU9w/PHq7sN0pt65bBHiK798Wf8ybEHMuUdwucNsxScV3
         kjBX7BgZCqR6q88chkGsLqhFV73/SMLfy/i4HgufpkQISoCPJUPgKIBUVm7uqgkle4
         zGMg7cpLZwmR1hNJNpMa8pGDVMdYanqAS/YLtfBoOlkU1LZhjLgoNx/ulLsaOekk5G
         XQv6mPx1pfWUg==
Date:   Fri, 27 Oct 2023 15:40:40 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Haiyang Zhang <haiyangz@microsoft.com>
Cc:     linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
        decui@microsoft.com, stephen@networkplumber.org, kys@microsoft.com,
        paulros@microsoft.com, olaf@aepfle.de, vkuznets@redhat.com,
        davem@davemloft.net, wei.liu@kernel.org, edumazet@google.com,
        pabeni@redhat.com, leon@kernel.org, longli@microsoft.com,
        ssengar@linux.microsoft.com, linux-rdma@vger.kernel.org,
        daniel@iogearbox.net, john.fastabend@gmail.com,
        bpf@vger.kernel.org, ast@kernel.org, sharmaajay@microsoft.com,
        hawk@kernel.org, tglx@linutronix.de,
        shradhagupta@linux.microsoft.com, linux-kernel@vger.kernel.org,
        Konstantin Taranov <kotaranov@microsoft.com>
Subject: Re: [PATCH net-next] Use xdp_set_features_flag instead of direct
 assignment
Message-ID: <20231027154040.58e5b09d@kernel.org>
In-Reply-To: <1698430011-21562-1-git-send-email-haiyangz@microsoft.com>
References: <1698430011-21562-1-git-send-email-haiyangz@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, 27 Oct 2023 11:06:51 -0700 Haiyang Zhang wrote:
> From: Konstantin Taranov <kotaranov@microsoft.com>
> 
> This patch uses a helper function for assignment of xdp_features.
> This change simplifies backports.

Generally making backports is not a strong enough reason to change
upstream code, but using the helper seems like a good idea.

I touched up the white space and title when applying, thanks!
-- 
pw-bot: applied
