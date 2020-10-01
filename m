Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A516280B6B
	for <lists+linux-rdma@lfdr.de>; Fri,  2 Oct 2020 01:48:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727017AbgJAXsc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 1 Oct 2020 19:48:32 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:10596 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728090AbgJAXsb (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 1 Oct 2020 19:48:31 -0400
Received: from HKMAIL102.nvidia.com (Not Verified[10.18.92.77]) by nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f766acc0000>; Fri, 02 Oct 2020 07:48:28 +0800
Received: from HKMAIL102.nvidia.com (10.18.16.11) by HKMAIL102.nvidia.com
 (10.18.16.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 1 Oct
 2020 23:48:27 +0000
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by HKMAIL102.nvidia.com (10.18.16.11) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 1 Oct 2020 23:48:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g6PH55SB9DlS5pUuqpD1xacgFcnhhjfKsCAayU1XnPisi7sdaPFE6DfC+cfKW4VWOHZnXOIM3KyatBdqCpsnwN+6q7vERDfrtTD8RNoY6sIoviUa8KL8ezNcNQXdK6SxGJqRO2PatekYhAYpHVgc72R3ypVswoHM0nHo73zdr9n4di5x1dnrtNQAeA2+olTFI3JxcquSkhxmd+QXnMfqrDxuITneLrKMuMfMBo8GCdiM/6XOS44w8YJWy+C8aMxbbmPuZ8tyDXZaPH/8kcuCJEo7aY9f/jl5y9mkDbJZMMVYFo3bl1oUFhoBCjjLAim2Q3iPJ3G+zXK4DzV1U6hUzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=no4YlkBaVXQ5D/bUHtd+33SlfdHjr7GDSWCzggurJfk=;
 b=AWxU4k/Ar+cgD7vFI9B6AiAuaxRuxIfnJHK797HVMze4L9+F5Pm9RmF0ZsqCAA6rxSenxLccixwIFXg4V/IAi+R9qhDO3MzkgxcH+3m6IwDPJKaeGSkSj8J0FOaXBVEU2XHKxzEu7vAx9FzPy0CECjRy/0DW9uuldFokqBuijcsmwwN5bg/fleOZdVCBL3mrvH+WmkmNrNfxcq2Hj+28a5Gk8TrF1GILBQdp5IahwzRVfO+WmIcFokLegXaMMEQVjMKlnwA1/bW5uUoxGHeSUqPRvTV7ihLlMRQW9aETpkyOmm0buc6PMrV3rJYIBsqwa8s6cm7UFCjxBITGYIQa7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB2859.namprd12.prod.outlook.com (2603:10b6:5:15d::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.26; Thu, 1 Oct
 2020 23:48:25 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3433.032; Thu, 1 Oct 2020
 23:48:24 +0000
Date:   Thu, 1 Oct 2020 20:48:23 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Rikard Falkeborn <rikard.falkeborn@gmail.com>
CC:     Doug Ledford <dledford@redhat.com>, <linux-rdma@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Jack Wang <jinpu.wang@cloud.ionos.com>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        Leon Romanovsky <leon@kernel.org>,
        Kamal Heib <kamalheib1@gmail.com>, Qiushi Wu <wu000273@umn.edu>
Subject: Re: [PATCH rdma-next 0/2] RDMA: Constify static struct
 attribute_group
Message-ID: <20201001234823.GA1209081@nvidia.com>
References: <20200930224004.24279-1-rikard.falkeborn@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200930224004.24279-1-rikard.falkeborn@gmail.com>
X-ClientProxiedBy: BL0PR02CA0006.namprd02.prod.outlook.com
 (2603:10b6:207:3c::19) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by BL0PR02CA0006.namprd02.prod.outlook.com (2603:10b6:207:3c::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.34 via Frontend Transport; Thu, 1 Oct 2020 23:48:24 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kO8JD-0054Y0-2U; Thu, 01 Oct 2020 20:48:23 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1601596108; bh=no4YlkBaVXQ5D/bUHtd+33SlfdHjr7GDSWCzggurJfk=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=c8CTGKREBeXDbv0GGN3YOz1WLPIA2PJHw2aRLvpzF60NU64oSG+d72C0QLYjTcGjo
         kzIhiiMwQpT9nfbuPys8G4arEJmTwlpfaHj+z0SZ2mpsxDzKEiRQR/CCW+YvGhjFWk
         tas2BrvTVx4UfV21z6IKYQ6p1aZRuEmYp4KUnca3KrGM4GylMos0+kxo9M5n6PLXBS
         D3GYZ4uXZB/YUZD6/aDvYyRUirh7B7s24CHYTde/rT2tL/XKfBVNjYBUETVFE/0VPC
         dmoiYG4w4R9EoZmjYMwWUDP0/T7X09eIIV43OxU2/Mhrbmw6468K51lLOFWld7bN5f
         Sw7eCvEyQhpCw==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Oct 01, 2020 at 12:40:02AM +0200, Rikard Falkeborn wrote:
> Constify a couple of static struct attribute_group that are never
> modified to allow the compiler to put them in read-only memory.
> 
> Rikard Falkeborn (2):
>   RDMA/core: Constify struct attribute_group
>   RDMA/rtrs: Constify static struct attribute_group

Applied to for-next, thanks

Jason
