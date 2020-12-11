Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D858D2D7FB0
	for <lists+linux-rdma@lfdr.de>; Fri, 11 Dec 2020 20:50:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391120AbgLKTtb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 11 Dec 2020 14:49:31 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:19209 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390525AbgLKTtE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 11 Dec 2020 14:49:04 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fd3cd030000>; Fri, 11 Dec 2020 11:48:19 -0800
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 11 Dec
 2020 19:48:19 +0000
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.103)
 by HQMAIL101.nvidia.com (172.20.187.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Fri, 11 Dec 2020 19:48:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BLeSYeOkDHQC3f12uNCD5Ydrg7VgPxZBrCZAFdaxYFLMy7E4Fid3FxXeEkIXkAzKTD5hW2yQQJvPY2t2h9GjsYq6ffElrk9Vuv68l6VJsoO5roaNdGJvZTOMNLsP0a6Y6D0NoqsmOBuHp5C6Lw+EL37/YNvuwpPdEDrFyUlmUmp08u3haQytN0dtdgLQOaZL2Z3PPymX1IKflMp71MkIXPdbyzh1hH2j+Ivj3YJ49/QTkQOGQvYjoPBNoApCyR759biBNTmNtZcX+q7hGeKhLNaN9HEsW9UC+Ifm8vntqOb1bjxuwAYZGlpjhF4bkxjz8UBLMDJnOmau00FHI0PMbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R9gy3SCAIZXs0DbN81jOsxawQQcLKQBDsVXDIjCaglM=;
 b=fiMRk3UD+drQxwxvtnGzQwA0reYq6A9oFaN54Xqjqj6SylXXp+xb32RoYR4werQAOsb4hX8bcoieO2IGOrcEQee3TuNB4UafwvuJN3VGdksWCcYvie2tvZUtRb5GBPB73ZeEMb8BTIWaHUEEa+qn0mbHMTtW3R4W9cVRzAbyn4tbbESilTkzIKkFl5ODaXUOLU+u7rhJYbwL95BJ+1g9aZ3R96t04jsYojv5XfAOQQSsjcQo6Cm10N/VIk0AAAS6WeofWMl7vjWNUNa0ITcOsdtcR5xNj3QeQYHczZoTJk+3L36kVcPnZGoEoHk8kfX8qz6gpoFFprrbSKFNC5GmEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3930.namprd12.prod.outlook.com (2603:10b6:5:1c9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.15; Fri, 11 Dec
 2020 19:48:18 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1ce9:3434:90fe:3433]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1ce9:3434:90fe:3433%3]) with mapi id 15.20.3654.018; Fri, 11 Dec 2020
 19:48:18 +0000
Date:   Fri, 11 Dec 2020 15:48:16 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Jack Wang <jinpu.wang@cloud.ionos.com>
CC:     <linux-rdma@vger.kernel.org>, <bvanassche@acm.org>,
        <leon@kernel.org>, <dledford@redhat.com>,
        <danil.kipnis@cloud.ionos.com>
Subject: Re: [PATCH for-next 00/18] Misc update for rtrs
Message-ID: <20201211194816.GA2223287@nvidia.com>
References: <20201209164542.61387-1-jinpu.wang@cloud.ionos.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201209164542.61387-1-jinpu.wang@cloud.ionos.com>
X-ClientProxiedBy: MN2PR13CA0002.namprd13.prod.outlook.com
 (2603:10b6:208:160::15) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by MN2PR13CA0002.namprd13.prod.outlook.com (2603:10b6:208:160::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3676.9 via Frontend Transport; Fri, 11 Dec 2020 19:48:17 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1knoOm-009KP5-UI; Fri, 11 Dec 2020 15:48:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1607716099; bh=R9gy3SCAIZXs0DbN81jOsxawQQcLKQBDsVXDIjCaglM=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=hG/B3HD47GPPq2fgSJQZJNZWb1iMj01L3xHiQXnBLj/KD4NzVtHbWoiB+cpEmsZpX
         2covYtN5dn36mVHsmGEOdQ6lHGdvQSUYCOjgWONCvFMh9+i+a4P/RYfQx+bUFq1EkT
         pi1a/b4LtTCa/YWSuc5V9Qy3SPtJm/TTMqZPWKrrNlFvdHEZJyUzsbrzuUC6PDdJ0y
         qOeL43BGtwPuVN04/FUt7lAvS0yfthqQSlrIOhfPUK79u5QYrMfdnjxi9epF2jPMt3
         dY/aKivWYX0J85qTgugzamN3CSmrDjfk4UywUaUNwvecxyg2fgQBDZzIdcifb0sFTi
         zbuNuG6+W83lQ==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Dec 09, 2020 at 05:45:24PM +0100, Jack Wang wrote:
> Hi Jason, hi Doug,
> 
> Please consider to include following changes to the next merge window.
> 
> It contains a few bugfix and cleanup.
> 
> The patches are created based on rdma/for-next.

Most of these are bug fixes so need Fixes: lines.

Please write a bit more in many of the commit messages, one line may
not explain things enough

Jason
