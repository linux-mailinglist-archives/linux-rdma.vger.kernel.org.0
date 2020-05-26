Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 985AE1E2ED3
	for <lists+linux-rdma@lfdr.de>; Tue, 26 May 2020 21:32:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389888AbgEZTby (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 26 May 2020 15:31:54 -0400
Received: from mail-eopbgr80050.outbound.protection.outlook.com ([40.107.8.50]:60992
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729215AbgEZTbv (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 26 May 2020 15:31:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G39cboZ2Tv17CvOqLdyK2LSzZAxhyipJ2K414/cwvPR9tzjOet/IdjXpIzXCdwCSmySU7esSbRC+9Eh713IruuZKwivTSWMF5FqOib66aHtGYTNYW4rzqZbAYROwO72vtnsmt3soIZJEcVm5TqA/s7SKJdnjsTUc451toIaE6eHAw7tAxNrDKyhvMjEAK3XosSSyj77B2Y5DsJS5xF/p2kURX2U2KbbEW7k0I/VdwAWuGGMR8lyv78mzBPi4CmG5wlYUL0prgxyhc1ZZmr9QclJW26iGPGolUVCmxhMxaP+C7qphjSJK3HBz7fF/wTcBRAxLVJRHjfwK+lo/At+qow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PEZ6+4JrCbz0ak9cOvT8B2V/1xX78opbAxevxOUU2ug=;
 b=MdbIN4elaK07TqVy+zR9IFiNjfXvDylybXkFrdOhXtAMQgeI8DelxRxj6lYnPmeWXV21XCmQ+1IGXBVlcOnlEjykSTegJ2Gr/nlYTgHnNssT1t0aP2MnGgfXtQEtqFtFsnC6ABKT3UQQY5tmKuzkz7DJLPF780ojGHJR5ErUCRE5zntn/r8zimkJr3XVImg8I3HR02E2fqKVWliNLi9/z/qN8q7ffftB5OTBI++3lES9IbxTzOMh6QPABGRa+fAI4CZikglg36ni046NhZtcVDyn1wuXSRn7/jUYLkaCvuvYDdYQD/b3mIdsFoqAxAqVkQr/S6aZeurMbF4F0ZFB7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PEZ6+4JrCbz0ak9cOvT8B2V/1xX78opbAxevxOUU2ug=;
 b=VVSiqw5VE9TBNe7FBFCEp2vrefTEVYhfdZdbrHaPeVPV/fh91dWTOz+yfV3ysJu3RLEl/rk5zZ2pjUM2eINK0kyI9ba41YduINnpRbtL1BSq0ReOAjXcSutOv5SQZFcs/mBySmlFLvoIGYMpMFpmJG6yUN6JwrvBka38N1qwYOg=
Authentication-Results: broadcom.com; dkim=none (message not signed)
 header.d=none;broadcom.com; dmarc=none action=none header.from=mellanox.com;
Received: from DB7PR05MB4138.eurprd05.prod.outlook.com (2603:10a6:5:23::16) by
 DB7PR05MB5756.eurprd05.prod.outlook.com (2603:10a6:10:90::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3021.27; Tue, 26 May 2020 19:31:48 +0000
Received: from DB7PR05MB4138.eurprd05.prod.outlook.com
 ([fe80::5405:3adf:37e2:25d8]) by DB7PR05MB4138.eurprd05.prod.outlook.com
 ([fe80::5405:3adf:37e2:25d8%3]) with mapi id 15.20.3021.029; Tue, 26 May 2020
 19:31:48 +0000
Date:   Tue, 26 May 2020 16:31:41 -0300
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Devesh Sharma <devesh.sharma@broadcom.com>
Cc:     linux-rdma@vger.kernel.org, dledford@redhat.com, leon@kernel.org
Subject: Re: [PATCH for-next 0/2]: Broadcom's driver update
Message-ID: <20200526193141.GT24561@mellanox.com>
References: <1590470402-32590-1-git-send-email-devesh.sharma@broadcom.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1590470402-32590-1-git-send-email-devesh.sharma@broadcom.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MN2PR02CA0024.namprd02.prod.outlook.com
 (2603:10b6:208:fc::37) To DB7PR05MB4138.eurprd05.prod.outlook.com
 (2603:10a6:5:23::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (193.47.165.251) by MN2PR02CA0024.namprd02.prod.outlook.com (2603:10b6:208:fc::37) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.26 via Frontend Transport; Tue, 26 May 2020 19:31:47 +0000
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)     (envelope-from <jgg@mellanox.com>)      id 1jdfIb-00074B-88; Tue, 26 May 2020 16:31:41 -0300
X-Originating-IP: [193.47.165.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b3dc6160-4fc2-4f85-0f23-08d801ab6e80
X-MS-TrafficTypeDiagnostic: DB7PR05MB5756:
X-Microsoft-Antispam-PRVS: <DB7PR05MB575649A9580CDC023C1837B5CFB00@DB7PR05MB5756.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-Forefront-PRVS: 041517DFAB
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 78JM7APQgxNmyZrqLezQXHVlw5dShbrYt1K9umZ9wyTvQFAGhm1OUKVszAL56xuwKRSZMZSeRnfAzXJdW13XIAdZ2Qccx+UVrhscn4jWWyd+lzlyJQbSjuLnw7Ri5Uqm6l5etiEfcTZ+LUNdYfk0I9gdQ/cRme9s64eEP8nn5ixILSA5oAFltbc3L3byH4id7f4ZeSnf/+37VQoONNo/If+bxzCt64ZSsyFx6rzHVXu4V001DbpKXAdGhQTucU3Rq1OK182ptG5PWFeqHtL2jng1up7j6xlprelsarG2fLR69PqPQY505w63ruHhaQKAnSjDnggzELtPv94umaWI2n5mL3mBZ9GpYIC8Y5xM2pG+bEcch0tlLpLW70bKvch6
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR05MB4138.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(136003)(346002)(396003)(366004)(39850400004)(478600001)(33656002)(86362001)(316002)(52116002)(66476007)(66556008)(66946007)(4326008)(26005)(9746002)(9786002)(186003)(2906002)(36756003)(4744005)(8676002)(8936002)(6916009)(1076003)(2616005)(5660300002)(24400500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: +8ESrcsCQ7dqSxUAsg2te4nKx/aQNMit/qqr57uqIP2QWjGZQF6GR4uk/lGt4VSywKB7StWeLTfPdtAOkwprc7FtLK+dJ+3QbibecQR6jJj4VsppRiXO9yn6Po4AKsFQ8XYtAH64XBBnPpma1SJMTBc2hh7m1cVNw9KOS0thsG5bcV2vbXrql459YX+AC1TwVWfx20s4blqwE/xEUBT7aab8g2nuUwnv4dhz6YkPmRoRlqBl91tv4Bw/T3Ey4dgVkNThW5mtLrwrkME6a9ILFgQmZVol100NRAsEc2uPL3FajkJUs6VLIH0A2T4KOfLHILI6mrdRYQKRs/Bjye5/lOfaewCfEnmJHx1XoW9QzgGz/RA5Ea9WSsdp6aqoYWyjTcYIgFEWx8nuP4C3+o2169yLfdhwIfJjRKT95ZofNkRKdyc4Qnodw+B+sOkkew/4otFAjLkGw/5CrC4EANlJjFBc4rGD2HpDJbaY9VWCo5ykP6+G8Qgg56Aso6dGq1pM
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3dc6160-4fc2-4f85-0f23-08d801ab6e80
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2020 19:31:47.9635
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o2/iTzLshKTviTZTzgfsg/xh6o9tsiHaqQdb5ePxcVQaH0qVsYrT5wtkIOjAEmWkQ1i2mdEWQNb/Zz0+BjmLBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR05MB5756
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, May 26, 2020 at 01:20:00AM -0400, Devesh Sharma wrote:
> This series is mainly focused on adding driver fast path
> changes to support variable sized wqe support. There are
> two patches.
> 
> The first patch is a big patch and contain core changes to
> support the feature. Since the change is related to fast
> path, the patch is not splitted into multiple patches.
> We want to push all related changes in one go.

That makes no sense, everyone else splits their patches.

> The second patch is relatively few lines and changes the
> ABI.
> 
> The corresponding library changes will follow short after
> this patch series.

You have to open a PR on rdma-core before any uapi changes should be
merged.

Jason
