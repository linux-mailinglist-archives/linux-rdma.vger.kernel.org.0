Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C177B7B4D93
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Oct 2023 10:48:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235925AbjJBIsR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 2 Oct 2023 04:48:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235917AbjJBIsP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 2 Oct 2023 04:48:15 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FC3FE5
        for <linux-rdma@vger.kernel.org>; Mon,  2 Oct 2023 01:48:04 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9CBCC433CA;
        Mon,  2 Oct 2023 08:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696236484;
        bh=XOGfDme2Cyeh/OHASdTs/HM2Knh8BBK+/6eoqIaikIU=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=ndcCCsQ2Kft3AH+fLlCQ2W5kVYRDuQtzVXSiVrQgYg7N77ezzL5+B3KRpkuDWt+pd
         Q5ju15yR0ojturo1iwg3oxp4q2erzCdNeqn1l9fdum0Db8AOHFsE5Zhuyz7quFGT74
         ZKXNGfhGD6pKH0hHvHZkUHhmNSPTU5zuqJiaDXb61NPCh2kRD7c0RjuhWH3qdpfKAp
         wppmzbK2TBnPNG4dssgC03HumnF9aeGPgayBkYKTMQ38xxc/c5DtCrjurcSrm6nkPs
         KhbI2IABb+UgUqwNShvHzEZZL6IBqoCRNZRYX+H8hmO8OO4maMRL7o5tjosycimJMW
         jIaKoFUOXdC/Q==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
Cc:     Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>, linux-rdma@vger.kernel.org,
        Mark Bloch <mbloch@nvidia.com>, netdev@vger.kernel.org,
        Paolo Abeni <pabeni@redhat.com>,
        Patrisious Haddad <phaddad@nvidia.com>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Simon Horman <horms@kernel.org>,
        Leon Romanovsky <leon@kernel.org>
In-Reply-To: <cover.1695296682.git.leon@kernel.org>
References: <cover.1695296682.git.leon@kernel.org>
Subject: Re: [PATCH mlx5-next 0/9] Support IPsec packet offload in multiport
 RoCE devices
Message-Id: <169623648084.22791.13771441990752696500.b4-ty@kernel.org>
Date:   Mon, 02 Oct 2023 11:48:00 +0300
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


On Thu, 21 Sep 2023 15:10:26 +0300, Leon Romanovsky wrote:
> This series from Patrisious extends mlx5 to support IPsec packet offload
> in multiport devices (MPV, see [1] for more details).
> 
> These devices have single flow steering logic and two netdev interfaces,
> which require extra logic to manage IPsec configurations as they performed
> on netdevs.
> 
> [...]

Applied, thanks!

[1/9] RDMA/mlx5: Send events from IB driver about device affiliation state
      https://git.kernel.org/rdma/rdma/c/0d293714ac3265
[2/9] net/mlx5: Register mlx5e priv to devcom in MPV mode
      https://git.kernel.org/rdma/rdma/c/bf11485f8419f9
[3/9] net/mlx5: Store devcom pointer inside IPsec RoCE
      https://git.kernel.org/rdma/rdma/c/eff5b663a6c304
[4/9] net/mlx5: Add alias flow table bits
      https://git.kernel.org/rdma/rdma/c/ef36ffcb381096
[5/9] net/mlx5: Implement alias object allow and create functions
      https://git.kernel.org/rdma/rdma/c/8c894f88c479e4
[6/9] net/mlx5: Add create alias flow table function to ipsec roce
      https://git.kernel.org/rdma/rdma/c/69c08efcbe7fa8
[7/9] net/mlx5: Configure IPsec steering for egress RoCEv2 MPV traffic
      https://git.kernel.org/rdma/rdma/c/dfbd229abeee76
[8/9] net/mlx5: Configure IPsec steering for ingress RoCEv2 MPV traffic
      https://git.kernel.org/rdma/rdma/c/f2f0231cfe8905
[9/9] net/mlx5: Handle IPsec steering upon master unbind/bind
      https://git.kernel.org/rdma/rdma/c/82f9378c443c20

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
