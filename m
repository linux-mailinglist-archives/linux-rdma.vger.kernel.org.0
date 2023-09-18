Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED23B7A4859
	for <lists+linux-rdma@lfdr.de>; Mon, 18 Sep 2023 13:26:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237389AbjIRLZz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 18 Sep 2023 07:25:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241770AbjIRLZs (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 18 Sep 2023 07:25:48 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70231C3
        for <linux-rdma@vger.kernel.org>; Mon, 18 Sep 2023 04:23:39 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64057C433C7;
        Mon, 18 Sep 2023 11:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695036219;
        bh=irwkX0wwN/AOYBXg8zXFA5Wmv3N3pC3ZkAifhIqr52w=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Ouxa46NT43FV23lTJwPCobk8mwid/AC/Dutq35xYbngIR0DfDe4yp9GYKDRd/mb8l
         vw/HRWa+/aNr2aHAAxyOWlCpFCMILJL7I1wO+3F9UevtnX1cJnFrddu1Build8es77
         kHMqMSQYHcmpdtC0bbwEnjgh3C0e3Z5eSa7ITwptNyy8laTxZT88OZ0sYIwbkJnGYg
         +eHeTfcGUYcvS7aoNbDPACAp8954MoyYhd0R14a5lgLELZkPzi10SXg55aDVuqeO0O
         KyZZzapg/rtzUniMzHkynN7FHrB6ko+/Z6LSwfeFhoMsqAJZFtbcXKRPD8vNMeBpCW
         +kGy6GP63tn1g==
From:   Leon Romanovsky <leon@kernel.org>
To:     linux-rdma@vger.kernel.org, David Ahern <dsahern@kernel.org>
Cc:     Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
In-Reply-To: <20230911215753.12325-1-dsahern@kernel.org>
References: <20230911215753.12325-1-dsahern@kernel.org>
Subject: Re: [PATCH] hfi1: Remove open coded reference to skb frag offset
Message-Id: <169503621543.107287.13157530191549953437.b4-ty@kernel.org>
Date:   Mon, 18 Sep 2023 14:23:35 +0300
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-a055d
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On Mon, 11 Sep 2023 15:57:53 -0600, David Ahern wrote:
> frag offset should be obtained from skb_frag_off; update the code.
> 
> 

Applied, thanks!

[1/1] hfi1: Remove open coded reference to skb frag offset
      https://git.kernel.org/rdma/rdma/c/1df1f730d765f5

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
