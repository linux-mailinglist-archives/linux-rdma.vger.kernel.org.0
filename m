Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 439D5577C40
	for <lists+linux-rdma@lfdr.de>; Mon, 18 Jul 2022 09:16:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbiGRHQi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 18 Jul 2022 03:16:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbiGRHQi (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 18 Jul 2022 03:16:38 -0400
Received: from gentwo.de (gentwo.de [IPv6:2a02:c206:2048:5042::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A488017594
        for <linux-rdma@vger.kernel.org>; Mon, 18 Jul 2022 00:16:35 -0700 (PDT)
Received: by gentwo.de (Postfix, from userid 1001)
        id 72FDDB00236; Mon, 18 Jul 2022 09:16:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.de; s=default;
        t=1658128590; bh=O9AROiTWuSvE/aWy1BtYS2lIl79rvkZbc9hOTJCiRh8=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=fzMieavK8doRW41DLLzwyNEyfY2bW/oiOqem45ca4FhRsFZmAnKs9MHfbdOD5gJFf
         ktMwCEEQgPl4UdBX/msLa7V/H+RZh6iAoeNbGKorkiKIK8/gl9IIXQnnyVymcQxOr6
         2cyBCq0Eef3icwrsx0e0vKV32IEvAldXnw47WwszWVOA66UitYTkigtnivzZTRkM8v
         BB66TyxgMWrl0Kl7Ke8lCtObg2P5mTJTHu3BWzy4+1g+HLkochPpymhsgUh4eKyLp0
         48zSt2HInUOynvJtb+KQ8VjXrMrmUmhViOGeyBcfPjXKzgu4u16em/gfi//MAvs53n
         4YIyAvmK6JdKw==
Received: from localhost (localhost [127.0.0.1])
        by gentwo.de (Postfix) with ESMTP id 7179EB001C0;
        Mon, 18 Jul 2022 09:16:30 +0200 (CEST)
Date:   Mon, 18 Jul 2022 09:16:30 +0200 (CEST)
From:   Christoph Lameter <cl@gentwo.de>
To:     "Tung, Chien Tin" <chien.tin.tung@intel.com>
cc:     Leon Romanovsky <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: Unable to create max_qp QPs on Mellanox ConnectX-4/6
In-Reply-To: <CY5PR11MB6534C428394164059E0BD6DBDD8C9@CY5PR11MB6534.namprd11.prod.outlook.com>
Message-ID: <alpine.DEB.2.22.394.2207180913320.484841@gentwo.de>
References: <CY5PR11MB65342B7EDE1F12E1012ACC09DDB99@CY5PR11MB6534.namprd11.prod.outlook.com> <CY5PR11MB6534B320E6A2794419E843F8DD889@CY5PR11MB6534.namprd11.prod.outlook.com> <YtOyotf+cAVqUaJs@unreal>
 <CY5PR11MB6534C428394164059E0BD6DBDD8C9@CY5PR11MB6534.namprd11.prod.outlook.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, 18 Jul 2022, Tung, Chien Tin wrote:

> > 2. max_qp is set by FW. Please contact NVidia support.
> I sent this issue to the mailing list because with different kernel I get different
> number with 5.18.5 creating 1/2 of QPs as RHEL 8.5/MOFED.

That is the same FW and the same HW? So the inbox drivers must do
something different from MOFED.

