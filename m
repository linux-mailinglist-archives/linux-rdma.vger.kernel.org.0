Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E729636EED
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Nov 2022 01:27:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbiKXA1S (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 23 Nov 2022 19:27:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbiKXA1S (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 23 Nov 2022 19:27:18 -0500
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2042.outbound.protection.outlook.com [40.107.102.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0123960693
        for <linux-rdma@vger.kernel.org>; Wed, 23 Nov 2022 16:27:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jszC7oS9KH29QB9rry/eqXG/WI2HK6n+p8Dq7QyRW8d9+t3zmmD966nWDoiEwZJbc55vsiz5PLQP6OnrUpizH6iJ5Fwm9YREVRisVSVyfpaOChlB4alNN8XslPcAE0Wk1v2Jg2CyJY57S/mUZ5cFqgljv5pPq6/EfZpcpNWiCjfjaMDjpeTlEZUa0oM/7MZA70LiHjXGYKvfp9zNZX2FrZzHuMOz3eVZavGZ2QXWb4fe34ep9b4Z6fCERsyYWwKmFRVbXUxo05lPoXlH86g0pcrYMBqYBwxWDwGhfsr2wWHovyaidjDJ1h5kn7BO1eimxUdaG7cYzIT7NL3Q00KP8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hvKxHXhxDUdCDCCYnycc4DLdZHMDZpxELcrs9lAU3H4=;
 b=FhysmLqUytymYFvR8oRZSFurgdizCWxPytVKGhWmO+AKAoEsAV++r9qbgQt2S4fiMiWQdi+N/+1ZHcaLGzyG88rzVk72TyPqvjPPwV+onXn4G09W/EuGHT26dfpT3MbKtru+H3+ijuBp1ifZ8DgkWUKWb5rG5eP4YmRwdI6vs5DHYfEFXaWnoNhO+COiFNA+Kg06Wyk5FCCWOGreY34u1EJXE4QmH60qQLLTqYl4cqB/oGptNBezIG86lBt1pDZhlYyhloTVyTQqVQ7A9P++L4a66/ujQBYKwxLOX2HKY6F/UKh+9g3SavygHEfROqNzVlI50k7BO6MHpkVxxRXMfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hvKxHXhxDUdCDCCYnycc4DLdZHMDZpxELcrs9lAU3H4=;
 b=VyeVQzPuyC5xvTFATqbgF/eH8lbKqLs1+onQdhLwpZTFd+bGwsXSTA+6ra+YfT6B67x5siwQAAAGwU8NtTizXozlSnk4ntL6/aAlV2rcjcQMAVU/GY5sTvn6kbUxbblzB8u2sDEyZa3I+tfeAi4iEwztP+hpDksQENaR7FDkmvsO0y+T80mUcSmSMsldo5sJXTemioWJgbrAuq5IItBr8gIrTJ9MtWWD3X5HsewpVBUWj3qsMr7xLc7+z0NP0s55FUqgT6LCM546/OG5KwqrOnhqp8/IUN3yGx8JliHJlq5CVXr1SQD2By6jrR6uUt1SNQgDbZHl0pe3e/KfIzzLHg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SA0PR12MB4560.namprd12.prod.outlook.com (2603:10b6:806:97::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Thu, 24 Nov
 2022 00:27:15 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%9]) with mapi id 15.20.5834.015; Thu, 24 Nov 2022
 00:27:15 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
        Dmitry Vyukov <dvyukov@google.com>
Subject: [PATCH] RDMA: Add netdevice_tracker to ib_device_set_netdev()
Date:   Wed, 23 Nov 2022 20:27:14 -0400
Message-Id: <0-v1-a7c81b3842ce+e5-netdev_tracker_jgg@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR04CA0015.namprd04.prod.outlook.com
 (2603:10b6:208:d4::28) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SA0PR12MB4560:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d9e35e3-7a71-4435-9a8c-08dacdb2a348
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k3d3jwrhu7COFTth41oPV1HpwfA9mgPRLjMw75rQRV54cqOdAVsvpljyiwLm8LWUi9XHxII1O/jASmOX68lla60iZHeWuc2KZzeZoISiIEvnSnNSKuFoT5+BvNj8aZc8q9m+RxDyFeYlHJQ/BSvqhl1NObXWsfpNKAQphYGP0P3GtEkjxyVuIWC3e0eCFb5wxxqHyB0KT6Ncs8Vx4w7AlUJpeyDWXJw61gsx5B0RDL2D8cKIg5x4y3J3eAiyCeOy7pZGDNHSZsxoyZgcQ1JpDF2xC5mUnBvr3GRbWlXQa0DcIWHqXKOtI0CzXJfc3B1BoKw3G/h1ymZrij6m5B0LV9BK5jbLP3xDx7FtkorX552s2YaNiD8b9GXj5lmZxJlQ2aTcNcCPXwMCa3Hv2MTNXQS7jYgs3S885rmB+UjS+DD3eD6iuACSe6r3cGCxG6yvhG4lXh3GfclvWS8WXdU05xdiO1v+pOqbZOkO2WyTtBv5KoYmqQj//XHE6XkKwaFJba2WV8hWYcAC3JCIUs8R3Wdgay6OfGwdK0tZlLn56NJVIV+F8V8j6EN4sa5nrZkfeTaH7MrQDrCoO2KMXQQoag8hTjXguII2gebi+hMF9GrVacYDodANfB0eeI3h7t9QIIOPLwsMObEmOf7PX+rj5mH1fBla+v6YCoUjY+Lw4lMKyFgTBznqq/KS0MdYryif
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(366004)(396003)(376002)(346002)(451199015)(2906002)(2616005)(66946007)(41300700001)(36756003)(86362001)(66556008)(6486002)(110136005)(6506007)(38100700002)(83380400001)(8676002)(186003)(5660300002)(66476007)(8936002)(26005)(6512007)(316002)(478600001)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?w1bMkle/PYbJplEpBkEi5b6jev6mMfqNb6emQBRzeK0WSRUHZedPrnZHVPsY?=
 =?us-ascii?Q?jHrHiOogB0UNvqzL5gNmU9Wq0U6fgoLZYonCadkldXgNggdgoCEMQXJqGdTC?=
 =?us-ascii?Q?iWBOPD3P9r0bXof+tEN//JWQx9Vyi53wx8pzOIe/8hcc06O7law1cACgojfr?=
 =?us-ascii?Q?VSxG4YX/oBuxzZZS237RPsr4O4AVGh0rPzBRrBVVWosphdJDFAoXqFZEDx4+?=
 =?us-ascii?Q?ay0UvpCGz8GMKYu8mXjwaOMs+PiT73u2Ury+yeug9xEGYpoFm1us+KhS+k4i?=
 =?us-ascii?Q?ntDvAD1LduPPBQ2Yp7kc+l4E1kFPoWaEHH9x3pDHzRdSwJI1CT13jS02TPug?=
 =?us-ascii?Q?DXcvgTiNwtDFml9OjHTlOv53zi0loguQuNJpRfvnz9QfxDtkboEXBBMB02Re?=
 =?us-ascii?Q?Q2hZdGwPsA+Bzek+W9RCgbHi6Tvrjn1jLhdOmpwLEboFPuX8KnZiECq6ovmP?=
 =?us-ascii?Q?jY4X5LL0GPsstOdXlJGczZJ3afh6rOxYGhniuwK9ymj/DRSCdLATq056Cnfm?=
 =?us-ascii?Q?NECy1NugwEZdRuHRN0BKy7+fhwTqu/b3WmlOInjKvKHTTp1X9JAMNxF4fUEB?=
 =?us-ascii?Q?X2ozRxYSANVeYhkYxyLrbSUH4IieQBo6SDXaTEqDPewznghYZjidbNwyneFE?=
 =?us-ascii?Q?ad6IbXxWYgPZdI6z77YkqeF7HWbzqbwmV/j82ilWnvTJmfzLxcZ7Fxo2KKVD?=
 =?us-ascii?Q?cgHRcTaB7DitOQBh8H7vGSq7UmyRSkEHX6EBihJbhD8Wol8fgNBKBoql8OwY?=
 =?us-ascii?Q?88UX+b8MEl7wHkp1hYXlNAYLguFwSXIBOQd4ua8Ul8Z/G3Syux/mOAbtMsDF?=
 =?us-ascii?Q?epTab6Bw6z3zNM8Ii3t3ncly8JTmVLNPPIwajC2mUWYXCtGSXNAybogxItaQ?=
 =?us-ascii?Q?RQvHKoJaYcATo+/TNHePBfkds9Ysn4r5qtvDdkQYAkYmbM8/NgTdZAeacGTt?=
 =?us-ascii?Q?D1a8rILrWwT7EZMWoLiPTX1GXmqpqEgLXE7meCYEXw0YMzdmPXBE9xhHT86C?=
 =?us-ascii?Q?4vVkKXv+1zBFiOrz6tnVQ8SNpzus0dPQNsNL9AlzGbuVVFXXm5ZNSqLuj1A8?=
 =?us-ascii?Q?YEuiCNoeaBgJx5ep0aNShYNtscdBCs0DwiqAeDcBl4zPa/COsSbs8nowT7it?=
 =?us-ascii?Q?t07Z3SOGGybXOTGdTAyu3b1wmFYWsyiMQeFSg7t4pxoamAoAOyNbuBSrcp4t?=
 =?us-ascii?Q?/ajTHsMNhwpQ8LZnHpwajVeRjn2o7wOHyfpB3mOEH7PQyGusMxUNlgeMBeqn?=
 =?us-ascii?Q?O59Iu/gB0ZMFu4EYqyha4mGefNwrflV+supNP13hxroiBQztLXOdNMLbvHvt?=
 =?us-ascii?Q?78bE7yCdBvja04S4zVTvjk/PMNM0wcv42vS3HKH3v6Cdm3g7FgJPNrUJFmw9?=
 =?us-ascii?Q?BGAWqg2fRu2BAl0DZuX/TiRYmO4hZ94WVc/iVeeqM9UKbTRUgnVUiUKNBNOt?=
 =?us-ascii?Q?F86LOnAha7UepOSgQFq+hdNvbke/c3OIOBkCpTlm+d5Dw5QJjXfmg2giXnP5?=
 =?us-ascii?Q?sA79+C8MEbn9HQ7C61S6H6TCE7iwTUI6+/o6z2MOYLegPnxvxEH+QTHYTN5X?=
 =?us-ascii?Q?CiiEjgr3vmyoMobnVYc=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d9e35e3-7a71-4435-9a8c-08dacdb2a348
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2022 00:27:15.5850
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cq+SUA4w5ZB/xwY6Nu1M8HIN2RXxn/owBQS1fbrg6Ms4At4AG9+BV+XQSD/vlvrs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4560
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This will cause an informative backtrace to print if the user of
ib_device_set_netdev() isn't careful about tearing down the ibdevice
before its the netdevice parent is destroyed. Such as like this:

  unregister_netdevice: waiting for vlan0 to become free. Usage count = 2
  leaked reference.
   ib_device_set_netdev+0x266/0x730
   siw_newlink+0x4e0/0xfd0
   nldev_newlink+0x35c/0x5c0
   rdma_nl_rcv_msg+0x36d/0x690
   rdma_nl_rcv+0x2ee/0x430
   netlink_unicast+0x543/0x7f0
   netlink_sendmsg+0x918/0xe20
   sock_sendmsg+0xcf/0x120
   ____sys_sendmsg+0x70d/0x8b0
   ___sys_sendmsg+0x11d/0x1b0
   __sys_sendmsg+0xfa/0x1d0
   do_syscall_64+0x35/0xb0
   entry_SYSCALL_64_after_hwframe+0x63/0xcd

This will help debug the issues syzkaller is seeing.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/core/device.c | 6 ++++--
 include/rdma/ib_verbs.h          | 1 +
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index 3409c55ea88bff..ff35cebb25e265 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -2159,14 +2159,16 @@ int ib_device_set_netdev(struct ib_device *ib_dev, struct net_device *ndev,
 		return 0;
 	}
 
+	if (old_ndev)
+		netdev_tracker_free(ndev, &pdata->netdev_tracker);
 	if (ndev)
-		dev_hold(ndev);
+		netdev_hold(ndev, &pdata->netdev_tracker, GFP_ATOMIC);
 	rcu_assign_pointer(pdata->netdev, ndev);
 	spin_unlock_irqrestore(&pdata->netdev_lock, flags);
 
 	add_ndev_hash(pdata);
 	if (old_ndev)
-		dev_put(old_ndev);
+		__dev_put(old_ndev);
 
 	return 0;
 }
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index a1f4d53a4bb636..77dd9148815b9c 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -2203,6 +2203,7 @@ struct ib_port_data {
 	struct ib_port_cache cache;
 
 	struct net_device __rcu *netdev;
+	netdevice_tracker netdev_tracker;
 	struct hlist_node ndev_hash_link;
 	struct rdma_port_counter port_counter;
 	struct ib_port *sysfs;

base-commit: f67376d801499f4fa0838c18c1efcad8840e550d
-- 
2.38.1

