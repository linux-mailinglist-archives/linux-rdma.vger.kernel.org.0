Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B31872A349E
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Nov 2020 20:53:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726995AbgKBTwu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 2 Nov 2020 14:52:50 -0500
Received: from nat-hk.nvidia.com ([203.18.50.4]:16863 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725833AbgKBTus (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 2 Nov 2020 14:50:48 -0500
Received: from HKMAIL102.nvidia.com (Not Verified[10.18.92.77]) by nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fa063160001>; Tue, 03 Nov 2020 03:50:46 +0800
Received: from HKMAIL101.nvidia.com (10.18.16.10) by HKMAIL102.nvidia.com
 (10.18.16.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 2 Nov
 2020 19:50:46 +0000
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.173)
 by HKMAIL101.nvidia.com (10.18.16.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Mon, 2 Nov 2020 19:50:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aJwhsk3YNt9UhE/AadufqK3LcYFLro1Fi48Skuo+S1c4OjUs6gMSo//HOYMoCY94glYov5oLkj8xZNWmDAG2OuCe1RRDVzHhxeKiIv7TUlGBVIgQIpXlBKLfvl1qChZK1Y8YQFfjlnS+fwKQQ14SAiM39GzA3ZpAWKmXsGDfmSC/R/7DXdXytIoq5t9tg3QvkuhRLwfR45Z5kI4XQD93rQ9I0Cb0iHooUFk7JuoVrZTCuq+hV1xVO1snvXy6QsSJ0f/G25aZUo8JgCwHtfh8KP1IZbeMO93YWyPKovBB4+WXzkt1dUeZrzvS21G4Xl1YYiLrImyC93Uvd0JWudC0Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KSaAaGRztEdroOPAo+PNLpaF1rW0l3BT+qD7UCXQ3es=;
 b=EN7kvcc64fyCurXij2J9caMEtqSPqUassHUinzpdUAmUIh7l8mVmFiJtukAFXP9zkiYjnp0i4iAqVs/xyz5v4aHjMDSlWg70DjcZv95nwMQUTI73NMvFotN+Uk6xE7TpHGO7slArDo/bwOmtaAtHje8KA4MqNS+Fw4krmeYxSty6kNb4FZ44PN1pvhQ9xe0UOChk0rB8n8yulRHXq13nmSXoOaXfrv2euOb2uSEHpSjj4Fq1eToLHovEoDOnstXVPAuF1VUA8nOiF2KN1kGRzHAWyS7KVHXvzoPP0NL1RyJRGa5v2OnHqYLaqqGlZiqFwV7BHYdE7Kz2q0Qkfx8HIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3017.namprd12.prod.outlook.com (2603:10b6:5:3e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.27; Mon, 2 Nov
 2020 19:50:43 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3499.030; Mon, 2 Nov 2020
 19:50:43 +0000
Date:   Mon, 2 Nov 2020 15:50:41 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
        Meir Lichtinger <meirl@mellanox.com>
Subject: Re: [PATCH rdma-next 0/2] Extra patches with NDR support
Message-ID: <20201102195041.GB3726340@nvidia.com>
References: <20201026133738.1340432-1-leon@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201026133738.1340432-1-leon@kernel.org>
X-ClientProxiedBy: BL1PR13CA0131.namprd13.prod.outlook.com
 (2603:10b6:208:2bb::16) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by BL1PR13CA0131.namprd13.prod.outlook.com (2603:10b6:208:2bb::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.10 via Frontend Transport; Mon, 2 Nov 2020 19:50:42 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kZfqj-00FdPJ-Jh; Mon, 02 Nov 2020 15:50:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1604346646; bh=KSaAaGRztEdroOPAo+PNLpaF1rW0l3BT+qD7UCXQ3es=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=Na+sBhjpBOd3KNKcvfYuZ+aUxLijYcz2MOW3eXvply/da91i0iUQa3aFYx+rtk/N7
         83QViNMA4OwBdFMBA6ouPVzXs+xaI0jTkUt5I6Isjc/r7n4VtVtXmQ/uqg6VsgA4zc
         jUyLInLwLMupEOHPw/PifNb337x/4qqKpuXOowvPM8W3FdIFG+Lm0a8roUT1QHUU+k
         PPYeIIPEyDfsR5ipmtemM3wz2dZGdmNxSo27fy1HCstPOr0oFzm35PSlz8GFfuvO4D
         DM1zx4QxPsb4tk6yDYM10nVMtwZ7UGoDdnOojlU5dxFfma3o93jTclDSImOWUYW01V
         an+JtQ23Wz6Rw==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Oct 26, 2020 at 03:37:36PM +0200, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Addition to the IPoIB patches https://lore.kernel.org/linux-rdma/20201026132904.1338526-1-leon@kernel.org/T/#u
> 
> Thanks
> 
> Meir Lichtinger (2):
>   IB/core: Add support for NDR link speed
>   IB/mlx5: Add support for NDR link speed

Applied to for-next, thanks

Jason
