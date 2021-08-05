Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 230FA3E0EB6
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Aug 2021 08:56:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232779AbhHEG44 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 5 Aug 2021 02:56:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:38156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229470AbhHEG44 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 5 Aug 2021 02:56:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C7B3560EC0;
        Thu,  5 Aug 2021 06:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628146602;
        bh=eE9abFSFd/KwJ9B9sJx14fz7BwuSyeThDwQqNlKc54I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SARwd2CRYoacgG7R0rd5Y1Dfjz2heO2jh2zbo8W/hiM9nEdklCtLMLw3xXVkz0FgY
         6cE6jg2AlYpLx9SPv8DQgmTPvTksS2Pi87Q63PbOQPVsbayA0BojhlNctBouYqoj30
         YcEQnoYTZUy8AHU9F0b0drdB2Rm/oYMP/kCUNwyD7on2TFfZmKvoxCjENuZQ+9Ez58
         jyPoMtAR/Uu/EgELuT1NILqWevp2vnfEFm243Ifl0Wbn9LshZfSGL/OIO8cUuSHZhd
         obUwBjnGQfqs8sVutT1msn3nLp29bRdflVR96F4m28iNKxbYSy/dIRhgW5i02WUsYR
         NVViDbSHQ9SQg==
Date:   Thu, 5 Aug 2021 09:56:38 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Shoaib Rao <rao.shoaib@oracle.com>
Cc:     Zhu Yanjun <zyjzyj2000@gmail.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH v3 0/1] RDMA/rxe: Bump up default maximum values used via
 uverbs
Message-ID: <YQuLpsA3NgzzBAT2@unreal>
References: <CAD=hENcTYfV1LT1=_e=eCNxdjr1Nmi+R3hH_CQn70MGRTKG7LA@mail.gmail.com>
 <eb24b781-396f-5bb9-89c7-3ca0f8b83849@oracle.com>
 <20210729195034.GF543798@ziepe.ca>
 <DF4PR8401MB1081385A8812159BA8E96A03BCEB9@DF4PR8401MB1081.NAMPRD84.PROD.OUTLOOK.COM>
 <14b9f35a-0086-834a-c05f-361a26befc13@oracle.com>
 <90ab34d4-92d1-986d-80e5-4253d208d073@oracle.com>
 <CAD=hENdFbF9VKhgLhSBomvQ7KvDFJhTNiPt-AfdWsKBVfo58MQ@mail.gmail.com>
 <7a1881c3-4955-5a24-7f90-4d60f2a607a8@oracle.com>
 <CAD=hENeupnOm1Jie+VM-t7dgEAtTp85HXjnFB+tj6bPihp5JKQ@mail.gmail.com>
 <37d69ea2-ab29-624b-1d02-44890cd078f4@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <37d69ea2-ab29-624b-1d02-44890cd078f4@oracle.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Aug 04, 2021 at 09:10:22PM -0700, Shoaib Rao wrote:
> 

<...>

> Can we please make sure that the code is working after the application of
> each patch or else it is a moving target.

We will stop to accept new features till RXE is stabilized again.
https://lore.kernel.org/linux-rdma/YQmF9506lsmeaOBZ@unreal

Thanks
