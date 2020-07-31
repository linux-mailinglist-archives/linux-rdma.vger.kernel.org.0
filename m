Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02C4B234A71
	for <lists+linux-rdma@lfdr.de>; Fri, 31 Jul 2020 19:47:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729958AbgGaRrN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 31 Jul 2020 13:47:13 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:7520 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729018AbgGaRrN (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 31 Jul 2020 13:47:13 -0400
Received: from hkpgpgate101.nvidia.com (Not Verified[10.18.92.77]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f24591d0001>; Sat, 01 Aug 2020 01:47:09 +0800
Received: from HKMAIL104.nvidia.com ([10.18.16.13])
  by hkpgpgate101.nvidia.com (PGP Universal service);
  Fri, 31 Jul 2020 10:47:09 -0700
X-PGP-Universal: processed;
        by hkpgpgate101.nvidia.com on Fri, 31 Jul 2020 10:47:09 -0700
Received: from HKMAIL104.nvidia.com (10.18.16.13) by HKMAIL104.nvidia.com
 (10.18.16.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 31 Jul
 2020 17:47:09 +0000
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (104.47.45.52) by
 HKMAIL104.nvidia.com (10.18.16.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Fri, 31 Jul 2020 17:47:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O+AQqnjV8H3rxYs8gcep7USNVbcobeYOQOkcG711OehwcZ9iX5Y25AZD462jygpaEE7U/HeiHQZc8CHBrOhuw/vCgNnWlMyw5OsFOmXAil0GOdubEmbXEMbuGZnO4Fg+MA6+WFQv2RL1+lwuIrQjnt5mFzkOrS81NDosQt2zNKR7Bx8IUlh249grKhJ568k/wj/c/V4Qo4u+7V/hG37EgOC3WFIswdd1igcPhTac8VVFzULn0Y6kQRSJOWUaYsKpQV1ZNl00dHPQbnAqNHJ64V5Pp/5HOq2NO4Uu2Rjhv8z9iVn+/YpadJ4VUOFNMNk5rYTeRJ3Rki6GmDrAPWPsmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GINfWWORb0RQAwLZu9e9wGj39RuQ3eqlBYb4br/p6oM=;
 b=Epi6jO60zhf8V6DwolBMRtcJjyzajkzKGSs9eiqYy4OXEn2I9sXLTGxSBjNE+5Oqi4o3XTsG8LdAMASRmlYJZ6szxYdQedsyCIYuCyxgFF14x4qYwSNZ90H2+qlUR1dybIuk8k/dC30vmN1dmg7ToTE2pkGnGKpxhr+T522/0F5R74akjI7KgeZZCDJTXTW2Kg9PuUjqibjkddyYc9wRSTkamZOEJ2dBmj68Heqa5EIlHNT47d+yZ+spkzHMsf/4i46kZkEdOMoNSUUcHxgKCaedoaTvy/BPkfrWXaxG2ihX7Ca7FGDQ+g8+9KjV1ofdUrqLVuMsX4dUwyyGxGbyFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1434.namprd12.prod.outlook.com (2603:10b6:3:77::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.16; Fri, 31 Jul
 2020 17:47:07 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76%3]) with mapi id 15.20.3239.020; Fri, 31 Jul 2020
 17:47:07 +0000
Date:   Fri, 31 Jul 2020 14:47:06 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Mark Zhang <markz@mellanox.com>,
        Alex Rosenbaum <alexr@mellanox.com>,
        <linux-rdma@vger.kernel.org>, Parav Pandit <parav@mellanox.com>
Subject: Re: [PATCH rdma-next] IB/cm: Consider local communication ID when
 check for a stale connection
Message-ID: <20200731174706.GA513882@nvidia.com>
References: <20200716104158.1422501-1-leon@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200716104158.1422501-1-leon@kernel.org>
X-ClientProxiedBy: MN2PR22CA0022.namprd22.prod.outlook.com
 (2603:10b6:208:238::27) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR22CA0022.namprd22.prod.outlook.com (2603:10b6:208:238::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.17 via Frontend Transport; Fri, 31 Jul 2020 17:47:06 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1k1Z7a-002A9M-1e; Fri, 31 Jul 2020 14:47:06 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 224a9ec8-1bec-497e-9924-08d83579be1e
X-MS-TrafficTypeDiagnostic: DM5PR12MB1434:
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-Microsoft-Antispam-PRVS: <DM5PR12MB14342577F6155D2D83B1AF1DC24E0@DM5PR12MB1434.namprd12.prod.outlook.com>
X-MS-Exchange-Transport-Forked: True
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P+yPhAcYu4DgLZa7Qlsm6aZmE+0wcGUPPAk0XE+vcIYWuD7v9uWUcGh/x1hsjf2XGMdrEQ0cSoVeJ8g0H9eJE96KMYiEsyeDtSUQXP1OIvIy8fhXzEfWZ8cIIE+uEypYsOFEukT4CGfpqK4y2Gtic+x05lMXdQwTqw292K9UgXrDL7MOE7UGhXVZRpvt+Sa4ofEHprRI7Ltl5wpg8ZVaRIbLNKG3Gp+vDAtEn/tGihdDEDNJZzhht3h1dlBSNjAm3LOgN05HAsRjIA9Js+uwKWW8n0TATK/AnB+QQPQFgQQ/6iTPr4vAVy7fAdLxcXaxdIYLvJwP92Ed0CCb1CqeO2pD9hDbO23f00e0owK0HyIM0dX70mBWudfghr4sE/+f
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(396003)(376002)(346002)(39860400002)(366004)(107886003)(2616005)(2906002)(36756003)(6916009)(478600001)(426003)(83380400001)(8676002)(8936002)(1076003)(33656002)(186003)(5660300002)(9746002)(9786002)(86362001)(66476007)(66946007)(54906003)(66556008)(26005)(316002)(4326008)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: jOGvy2NdXFm4OAvVj0n5IItVMX5z6YCDf0jJLjClGjXot76MX3LiZuKqg/OAcqPdW+bNgrvwSTN+Hk8c4N/urHw6hwHTm+1jWiiKegM9fUe8+FLyTIEoWwLbJsPzwosddMlmhV2v+Wbj3MJv5b2kbqckY3C3wxwIEXkIAF6NnlOs2ULPfhMtv3q5Uxxvx/mqygPOdYZ+CcAFBQoUvMo8RJ+Mt7vjyafS3Fk7n3TxSd9hN3gn0hDrF8/LtqDN+fjQCKlxPHUMhWA1c+7pYKuUZ6vfHkexG2OV8K5zew1P5NK+QOsfOY3UgQca4kheddbNRLm6V7kY6eVsJCQHa3yENZuH7q+Ca/tqT9qEa8YiqW56RmUr2RNlBy27tzpiJm4yXCB/ET+ES3TfgJcQEdOYzo9+Y30PhjxiPpAMoGVVtzakFkFwacrVxO4dPOinM92A8Del8XM7V6qtFUWPaxxVS0ltUD8y0x1R6PaaJUYhXdcJeXgKivPjek0WuQ4TKQkZKd2sY6QpdLPtMLOnU+Yq/XuSgHcwkfLBK9Mfg/3eGf0ZhNhxzkm3wC89gyRlRs+nKr8WkYDbS4lq4YeS/4ZqP2AhIFGdr23XBwflvUenfMBj/6Wf+uw/c8CFjxbVI0006aQf5pqSXbzHBnTNAMt7FQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 224a9ec8-1bec-497e-9924-08d83579be1e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2020 17:47:07.2684
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ll7jRyBdGI6gVR97C4hoaXYjqzCTWpnRC/xLvZcTXZM2UEUiIL8Gh7lZrh+3w8/c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1434
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1596217629; bh=EvTBS9L08OHA3YTlP/QfEsaQFssEChHBTTZ5EF/rs1U=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:Authentication-Results:Date:From:To:CC:
         Subject:Message-ID:References:Content-Type:Content-Disposition:
         Content-Transfer-Encoding:In-Reply-To:X-ClientProxiedBy:
         MIME-Version:X-MS-Exchange-MessageSentRepresentingType:
         X-Originating-IP:X-MS-PublicTrafficType:
         X-MS-Office365-Filtering-Correlation-Id:X-MS-TrafficTypeDiagnostic:
         X-LD-Processed:X-Microsoft-Antispam-PRVS:
         X-MS-Exchange-Transport-Forked:X-MS-Oob-TLC-OOBClassifiers:
         X-MS-Exchange-SenderADCheck:X-Microsoft-Antispam:
         X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
         X-MS-Exchange-AntiSpam-MessageData:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-AuthSource:
         X-MS-Exchange-CrossTenant-AuthAs:
         X-MS-Exchange-CrossTenant-OriginalArrivalTime:
         X-MS-Exchange-CrossTenant-FromEntityHeader:
         X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
         X-MS-Exchange-CrossTenant-UserPrincipalName:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
        b=ca4lv6VNhN9IYaWXkK4NzuNaTDUA4Wqr/BzXzGnwkmFb6ZTbuf9MVeQX9G93Y+9pe
         L5Cwq5mKojC3nB39Bxe83jcVq5tyieEEPjnz0wzkMeGVC0XiUZW/QFOZ9CSVn0Nukg
         XUxxLYnvOL4yuPAiusl0t3JgTR/9ArXfxpZUtxO1UkFpQS2Zd5SF4Q20W7lmF7Jh7B
         xfh73ZWxNxk/PSi/P1WgPuWBGl6HE1VvtnKjb3dw3bmzjilondhWsi0j/U7HVOopNB
         zjZXusYA6mQ97lh3RpJ3smwhqFnE/0rwPeiHD41980WpYKkE4K/bNqgbhkQ9rjBxU3
         uyriYWf6+bp1w==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jul 16, 2020 at 01:41:58PM +0300, Leon Romanovsky wrote:
> From: Mark Zhang <markz@mellanox.com>
>=20
> Made the check for duplicate/stale CM more strict by adding comparison
> for remote communication ID field.
>=20
> The absence of such strict check causes to the following flows not being
> handled properly:
> 1. Client tries to setup more than one connection with same QP in
>    a server (e.g., when use external QP), the client would reject
>    the reply.

This is correct and required behavior by IBA:

 12.9.8.3.1 REQ RECEIVED / REP RECEIVED

 (RC, UC, XRC) A CM may receive a REQ/REP specifying a remote QPN in
 =E2=80=9CREQ:local QPN=E2=80=9D/=E2=80=9DREP:local QPN=E2=80=9D that the C=
M already considers
 connected to a local QP.

> 2. Client node reboots, and when it gets the same QP number as that
>    of before the reboot time, the server would rejects the request.

IBA has a specific flow that should be followed for this case:

 When a CM receives such a REQ/REP it shall abort the connection
 establishment by issuing REJ to the REQ/REP. It shall then issue DREQ,
 with =E2=80=9CDREQ:remote QPN=E2=80=9D set to the remote QPN from the REQ/=
REP, until
 DREP is received or Max Retries is exceeded, and place the local QP
 in the TimeWait state.

The fundmental issue is IBA does not include the SRC QPN in any RC
packets. It is the responsiblity of each end port to ensure that only
one RC QP is setup sending traffic to a given DLID/DQPN pair.

This is what the timewait mechanism and these checks in the CM are
for. The proper CM use will ensure that the local QP targetting the
DLID/DQPN is destroyed before the cm_id enters timedwait, and the
timedwait will prevent a new QP from being established with the same
parameters until the network has flushed all packets related to the
old sending QP.

Jason
