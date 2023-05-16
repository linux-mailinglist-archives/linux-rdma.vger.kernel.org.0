Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D9967055FB
	for <lists+linux-rdma@lfdr.de>; Tue, 16 May 2023 20:29:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbjEPS3V (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 16 May 2023 14:29:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjEPS3U (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 16 May 2023 14:29:20 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03EF2115;
        Tue, 16 May 2023 11:29:20 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 4D90B993;
        Tue, 16 May 2023 18:29:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 4D90B993
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1684261759; bh=fldOt2c4W0epFwkV2ebO//Gwa4urHzMuc6Ti0LJKCK8=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=Ojm2CyCHooKhnhoZ9v9m7FV3E3P8Nnk7JUP0wBXIZM8d8xPPDGIoNJVnZZWyi9o/S
         t7MfGQUuSLNQuI6BWtup2wy5XOIggnCJUsVsFXt2J4ZMWWRyTV4iyphjy8EkNXAYPr
         kXaSt64Nukrg6NhyiOnL5b0qT4QIGCrJgL96VUlv+y0k2MadJNZll4JBjyGb4X2Y6U
         ELD1dx5vgRTZBOKtkMOlWfM7AkqQeQJmNXDq1adYClSnk9pZ5e5aIV2dSvwLeDaxVa
         Vv7YBo9J8j4H14yLO+4tpSTwffDkD7mjhgj0H6mimw1VYr562RFKauUowWtASyFKAo
         y3R+6XvlX3/Ag==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Linux Networking <netdev@vger.kernel.org>,
        Remote Direct Memory Access Kernel Subsystem 
        <linux-rdma@vger.kernel.org>,
        Linux Documentation <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Saeed Mahameed <saeedm@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Gal Pressman <gal@nvidia.com>,
        Rahul Rameshbabu <rrameshbabu@nvidia.com>,
        Maher Sanalla <msanalla@nvidia.com>,
        Moshe Shemesh <moshe@nvidia.com>,
        Tariq Toukan <tariqt@nvidia.com>
Subject: Re: [PATCH net v2 0/4] Documentation fixes for Mellanox mlx5
 devlink info
In-Reply-To: <30df7ad7-3b8b-c578-b153-7bf0a38fa0cc@gmail.com>
References: <20230510035415.16956-1-bagasdotme@gmail.com>
 <30df7ad7-3b8b-c578-b153-7bf0a38fa0cc@gmail.com>
Date:   Tue, 16 May 2023 12:29:18 -0600
Message-ID: <87zg64b05d.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Bagas Sanjaya <bagasdotme@gmail.com> writes:

> On 5/10/23 10:54, Bagas Sanjaya wrote:
>> Here are fixes for mlx5 devlink info documentation. The first fixes
>> htmldocs warnings on the mainline, while the rest is formatting fixes.
>> 
>> Changes since v1 [1]:
>> 
>>   * Pick up Reviewed-by tags from Leon Romanovsky
>>   * Rebase on current net tree
>> 
>> [1]: https://lore.kernel.org/linux-doc/20230503094248.28931-1-bagasdotme@gmail.com/
>> 
>> Bagas Sanjaya (4):
>>   Documentation: net/mlx5: Wrap vnic reporter devlink commands in code
>>     blocks
>>   Documentation: net/mlx5: Use bullet and definition lists for vnic
>>     counters description
>>   Documentation: net/mlx5: Add blank line separator before numbered
>>     lists
>>   Documentation: net/mlx5: Wrap notes in admonition blocks
>> 
>>  .../ethernet/mellanox/mlx5/devlink.rst        | 60 ++++++++++++-------
>>  1 file changed, 37 insertions(+), 23 deletions(-)
>> 
>
> Hi jon,
>
> If there is no response from mellanox and/or netdev maintainers,
> would you like to review and pick this series up?
>
They seem OK other than the gratuitous use of Fixes tags.  The netdev
maintainers are generally responsive and on top of things, though, and I
don't think there would be any justification for bypassing them here.

Thanks,

jon
