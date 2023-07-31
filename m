Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ACC1769B63
	for <lists+linux-rdma@lfdr.de>; Mon, 31 Jul 2023 17:54:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230382AbjGaPyL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 31 Jul 2023 11:54:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231199AbjGaPyK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 31 Jul 2023 11:54:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D0B2E57;
        Mon, 31 Jul 2023 08:54:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A5262611CA;
        Mon, 31 Jul 2023 15:54:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE80DC433C8;
        Mon, 31 Jul 2023 15:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690818848;
        bh=s0kAjQJcavEtn4qvC3HzqyRFEFYgPphknK2SvtAotiA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Ai5cILmtb3ikR461b8t7idKX14GQLmt2bs/fBuBiOKhKc+OryJNDPvPleFOOZTVlc
         HmshJ1DkT3qyLODzm6f4SpXnv8+U3LBo31m3Z17rA+CIfHwe4gm2oKWJk87lCMsgSE
         VmSxUS9E53HwBkcY4fkB166eUYdM9KDAH1kkkkSsw4mBqgGOm94IcY/dOS2yfD9wWX
         ZcmsLKcbH55gYPozq7qpkWENSU79Fgm+QIrcahW9o5w469Pa9DjjKw0TGGEMKGVcZU
         lSJGonui4w8fDPFS/pUly4U4Y2r/1p/fY1Ku5X0siK5onBeTBT4SlU8QJaIN2oKqX1
         UQe/LZhANotNQ==
Date:   Mon, 31 Jul 2023 08:54:05 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Simon Horman <horms@kernel.org>
Cc:     Lin Ma <linma@zju.edu.cn>, michael.chan@broadcom.com,
        davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
        ajit.khaparde@broadcom.com, sriharsha.basavapatna@broadcom.com,
        somnath.kotur@broadcom.com, jesse.brandeburg@intel.com,
        anthony.l.nguyen@intel.com, saeedm@nvidia.com, leon@kernel.org,
        simon.horman@corigine.com, louis.peens@corigine.com,
        yinjun.zhang@corigine.com, huanhuan.wang@corigine.com,
        tglx@linutronix.de, bigeasy@linutronix.de, na.wang@corigine.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        intel-wired-lan@lists.osuosl.org, linux-rdma@vger.kernel.org,
        oss-drivers@corigine.com
Subject: Re: [PATCH net-next v1] rtnetlink: remove redundant checks for
 nlattr IFLA_BRIDGE_MODE
Message-ID: <20230731085405.7e61b348@kernel.org>
In-Reply-To: <ZMdfznpH44i34QNw@kernel.org>
References: <20230726080522.1064569-1-linma@zju.edu.cn>
        <ZMdfznpH44i34QNw@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, 31 Jul 2023 09:16:30 +0200 Simon Horman wrote:
> > Please apply the fix discussed at the link:
> > https://lore.kernel.org/all/20230726075314.1059224-1-linma@zju.edu.cn/
> > first before this one. =20
>=20
> FWIIW, the patch at the link above seems to be in net-next now.

I don't think it is.. =F0=9F=A7=90=EF=B8=8F
