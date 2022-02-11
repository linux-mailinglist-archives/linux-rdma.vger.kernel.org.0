Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BBD74B2D40
	for <lists+linux-rdma@lfdr.de>; Fri, 11 Feb 2022 20:02:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239158AbiBKTAm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 11 Feb 2022 14:00:42 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231374AbiBKTAl (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 11 Feb 2022 14:00:41 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2042.outbound.protection.outlook.com [40.107.223.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30FC7CE7
        for <linux-rdma@vger.kernel.org>; Fri, 11 Feb 2022 11:00:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NqhK8TWKWlWzasdh38N3O5t1ieBaTBP4hBeCUzXoAd1QSD7cbp2KWDZz5OJRnTlRWWf0W83++DPMOclEuYHK27YHT1WI+SFXJZMrgx97T7mrqQD14UJjbL3E1JYDW8/HbbsKlGY8l3C4moKN9TwamUuWmIA3brg0EqaVcsDrfARksqVTZ2NIWbNjwUC/ZJEX+7ABU+j4bCBNfhNz46VbnAup42sBwpxAr1IENYs+jIXVj5Bn38jHMQZtsba+86kK/usxt/5VoxYDvTebGn24kla8gosPRF5o2DQO8dDvdYqXzbJ/TPgHXUybFy/5w5SHc7AkdTafjjnveenrY3NW4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kfC1QBuJnyxp3P1MfldcCljS84OvdoMbueH5yOS2/Lo=;
 b=ezMZvkU7csjK8u3kHBKE+b877eyPLDOzmlhhUwhO/ue1QoejbcKlCG2c91BSwbASLVUoy9XADLOp/kHmRNUuH6Hg1iPG7deb8AKReblPoW9BK2gRoHMfWLfms9afnKN4s6N5QUJkxV+G6aHS5iFUaikd65bJj5l/8ea3ERrnrSDJDLYdpZeceWAlx0e1gc1f8Ub5jgDkDBdwGds4hHZ6Bbds//yJQJG2L5G/Oe6zaJm8BnYtBWDtJwtbN2QD0tVk8KSG8eXpQ1WwwMp+8oogGKcD3ruZZqYz+CKOLxmBk9ozCTmirt655eOxGK6z0kJO1Qnnqz1bFjpXg3FkxDNfUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kfC1QBuJnyxp3P1MfldcCljS84OvdoMbueH5yOS2/Lo=;
 b=qs0dzHBHyZOLw3LxQZWsdKILXUSP0PGUqz51vj2t1uMgQ2lqHbmkQxpcDK8569QDVOfwhXNTQ7DOUl7mll3m5dV9x9yOPlBtVEV5DF2cK807PDOwag1KQp0x0lIqZZmwehC1/ClwuxdlEYitQ4FDbbdlkYli6WIPR1OKsEIrNqm8zBpiXQz86JB7/6h5AscqCX68Pe6/AJJQeGNoAejELjEAJzpKHpUReQAULFlNKniP1r6cojyf60BZSoeE5umT4p/fzVHH4UI/LS6X7uz9hTdPUJkPSwCy1/Q55QzyoMys1EAOjbDZCyw22RPqNJs5RVH1AH6Y873/aCfOLKFvnQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by BN8PR12MB3378.namprd12.prod.outlook.com (2603:10b6:408:61::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.12; Fri, 11 Feb
 2022 19:00:37 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::e8f4:9793:da37:1bd3]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::e8f4:9793:da37:1bd3%4]) with mapi id 15.20.4975.011; Fri, 11 Feb 2022
 19:00:37 +0000
Date:   Fri, 11 Feb 2022 15:00:35 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next v11 01/11] RDMA/rxe: Move mcg_lock to rxe
Message-ID: <20220211190035.GA612278@nvidia.com>
References: <20220208211644.123457-1-rpearsonhpe@gmail.com>
 <20220208211644.123457-2-rpearsonhpe@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220208211644.123457-2-rpearsonhpe@gmail.com>
X-ClientProxiedBy: BL1PR13CA0192.namprd13.prod.outlook.com
 (2603:10b6:208:2be::17) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 99c69f0e-c598-4c83-4ea2-08d9ed90c9ec
X-MS-TrafficTypeDiagnostic: BN8PR12MB3378:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB3378F818A796CE77B3DCDA33C2309@BN8PR12MB3378.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d7XTtJUXt4ZUh93yuAcXl58QfEiNwATM5xiTfycn5gRstUnosCkJirfHn5Za4HijYkQZkSzk+YnQa4PX2Qw59gKA6Y26y8Sj2DgOA6UXFXrBvEkpnKVfg06iKlUrebLHe2EDGaPLndjU4Fw075sST+KoVzdHf8mQhTU3O26Xu/Fl94FalyVklQv8vXeVIEWskIAhEwWHDt0z0VgJ+ULaW4OjhaB8BY2fKtE8iUqxuRu9p5NOEOhHod2mU7S3WchWcrD8uCPiKIRPTjRdsBI3OWmoVzXM8m7PqocufUPGAyX8ZOSYMU1IdeGp5AhsTTUp1+V5IT0555Q7bkhSoRRdMef/BXZuEDCz0hw787V8MbyF2Q7l5fZwxZd484oCaTeiY45iDuw8SFRJlnP1poRti4A+uaNi26O+pHR4I1c/wwitpLplE8IUV85AP0sr33morODFQ4oX6F5pUpJNhjTgelCEJomUJrpJ6uUDXkyNaGyJOEp61IW0a/E/P0yABz+T5YsWlx59jqfcc62eu1yBW+SEyozdo7crt+AGdQzifvyjgrP0TQXhl2PT8DVLCMvGDN0fWgZ+GHpldRthwCQuOh7LtTJB62r3bxnt2Fkx9OTb6JuUKlxvB+EbevzIKWcd/Wbe1VRxf2oKDFiCQITiq0SPv2qC2GEDymZhiIkli5C4uUjXQJSv1HB106TendmaEM5pp8nv67KsGjukfknEtQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(83380400001)(38100700002)(6916009)(86362001)(66476007)(8936002)(33656002)(4744005)(5660300002)(4326008)(66556008)(6506007)(2906002)(66946007)(8676002)(508600001)(36756003)(26005)(2616005)(6486002)(186003)(1076003)(6512007)(316002)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?N0vmdWT0egzJKEcx8G1zo63D5wksariHaL1FmxtEUwHAIY2B8DKfF1jyhcwX?=
 =?us-ascii?Q?cGEQv3Glga26lxP5kjvzEFsSLH84EDuTrDLidx+rAfiPzX7nTkXGkUseipXz?=
 =?us-ascii?Q?NRON6yPDkxF8Sl42kXhj8amfsctRyHLszRG5lYAqRpDhLjgVUIlvudALATdA?=
 =?us-ascii?Q?w/9knT1rvBeO5IZJOSiUk9/AcLx+SenDiSgwxECklS5OI3ehYr5FRz2PgVWH?=
 =?us-ascii?Q?tkq4Wyn3R0jgdnYdxPCvcmVURoNJIGDVcA6j2d1TJOpLpTWkKG3TMYZ/8nsh?=
 =?us-ascii?Q?VJx6YI+G1qP5hvdRPpIA6ayNk07k1xHB6NlPCa8RSlIyj0n10/qd5/LCynl1?=
 =?us-ascii?Q?nhbQuLopMKUGrLbqivOutzZJNlEttjhF4UJNKZD1NYr4QxRc0MZDOLswkfE1?=
 =?us-ascii?Q?U+A41Bn/Gb6VzVv9uUMfSAnFJnFSU2uysw+B+RnZwnhDfgnGWGDwqG0DFqjt?=
 =?us-ascii?Q?c6FQjvomqzFh23qhmu4cJscvX65P0YepuOy1BzBCWshxaJ6nHKazdbkl5/wz?=
 =?us-ascii?Q?LAbQUFn8maUjLBr49mrnRG02W4odNl7IrYnmzVrwIlaqcy6soghSd4EdOGGE?=
 =?us-ascii?Q?Mbc/KTFV7plWrQSCgAJBlFCRPG9+ZwqM/1ITBzfiEj/uOLGHB352oTPvj7XO?=
 =?us-ascii?Q?6GulA8p63dFZPJn8xyZ0C0cB/cfKBkAPFZvLTTnx64sogi7x9gvqRKc/2+Yd?=
 =?us-ascii?Q?qEqvm3MHoL1tkYkOrbN9O+96hMHPLmhkW2XWqYWUl2lgH/tQ14U8XbhQ2RUw?=
 =?us-ascii?Q?7hfzXqAS1VPVzcQ8rgduYH20M4NPzSoPO16si0BhcAdNFy284ISGQ8aFM2Oi?=
 =?us-ascii?Q?Xq9/ntZP2NYdrPyFKvhzj0C9zJyP+sMPIVG6ro7Uv+dYwBkK6yfT5k/lS8gq?=
 =?us-ascii?Q?JkHty0L79gJYlc3JZg19Mo0mAEJo92pqyvC1KRDOg+egnrH6wMjw9QmoS6f9?=
 =?us-ascii?Q?4fo97Gtw8rRIH0UYSNkcJ6DgN25EYOZcLKtN67tZtXz5aKinJpAFuOxtxBhY?=
 =?us-ascii?Q?hRN50QZeR/JVV13ZKphz8hG2zgP0B5U3KjuMLL9qjHydD0IyfMD1oIYgVtWW?=
 =?us-ascii?Q?yZVFVZV6NVCHtJvG8Y1a2vDFcXDwSZ7obQXnYJ0ac5rt3gCyMGV/A1yaubrG?=
 =?us-ascii?Q?ZlFI58JpwuTnkCxtHUU/bcputCf1y80euBYQqhdOxKE5EaudCpndhvravkRB?=
 =?us-ascii?Q?8CgQlcxQAYyOIGxbQTAFCWc2VOuHRz3GTcQR55CY60NfFLPZ129Wzq32YjSA?=
 =?us-ascii?Q?tYDkPMCFcrpeLmCDVP+w2fX9SL+a9Kg5gcVgsurVq+GGuCZFXnUvg4YSuAw1?=
 =?us-ascii?Q?YF+6Nx4pAbPVEn8v568oDoL0Tv+kNHYm7F1YOiZqB3v5hra41+0DVdP2DlvU?=
 =?us-ascii?Q?8JGMv6DW+V5HL+/7jfAMu4q4AlAJEzz7Luf3x5c3nzTegcbzltYs2cpodQzr?=
 =?us-ascii?Q?WM/SrwhXNEZ3W75hTz9m34bXb5VAvlP0E+gYS2h+HYSbxBoBiPfPOsu0iL25?=
 =?us-ascii?Q?wdsG5rVXqkdf0E5h7/irflc3EMqNocJs/Zi/Hiu7xoPTS6qmYojzvS2oJxps?=
 =?us-ascii?Q?w54BWmUQkibmXF3gpio=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99c69f0e-c598-4c83-4ea2-08d9ed90c9ec
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2022 19:00:37.0134
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yaZdJZsI6WexzzuQqIWsJ2j4SBDN254sqxW5hrYO8BL6PZSHSoSeHG6g6HSNtVzo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3378
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Feb 08, 2022 at 03:16:35PM -0600, Bob Pearson wrote:

> @@ -62,7 +61,7 @@ static int rxe_mcast_get_grp(struct rxe_dev *rxe, union ib_gid *mgid,
>  	if (rxe->attr.max_mcast_qp_attach == 0)
>  		return -EINVAL;
>  
> -	write_lock_bh(&pool->pool_lock);
> +	spin_lock_bh(&rxe->mcg_lock);

>  	grp = rxe_pool_get_key_locked(pool, mgid);

Now this calls rxe_pool_get_key_locked() without the lock :\

This is all fixed up a few patches later, so it only hurts
bisect-ability, do you want to fix it?

I looked up to 'Remove mcg from rxe pools' and it seems fine to me
otherwise

Thanks,
Jason
