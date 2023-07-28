Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09D587669CB
	for <lists+linux-rdma@lfdr.de>; Fri, 28 Jul 2023 12:05:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235607AbjG1KFV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 28 Jul 2023 06:05:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234121AbjG1KFF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 28 Jul 2023 06:05:05 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2108.outbound.protection.outlook.com [40.107.237.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D91744A1;
        Fri, 28 Jul 2023 03:04:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JvcDolhRfT9bHUTJyiiYqydp5RioyXzCYBRSTXfcLiUix4lNhBCYWaL8LqSZm+JRrhRP2hVbWEfY/O/3ctyXSg5gFOhwHCckGD+HZ5jS8hAgKh+TPQg5TJv6ljtucRAvG25ZczaAxRPLCiMFxAGDcaBJ+bFzahu0Hrl3cQGWIVbfjXKA7suEXz/+yx2WKZiVC88fwh0G5FWKeYSq3rqLXzD4gq9mQ/Ceu6vaRQCSorGWF9hnF5O9mf+7k1nTWW8vDRaBII27s0kDBtdGFxIHumHORSPSNmRej0b5V0KZpsnjqZ8eF5fuV/MbLiHGZlM3V2/y55JnZ/mW/A6v0PATwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3MpcEjgnI1jwhWnxOdnAGnUWaShIx3pj+C6e5uVL6kI=;
 b=XqBNKOY6t25yo2sbQV0kTbcA9X+bwpUkaOY8fW72tz81Ji+MPKnTvJiEjMuCi6IppzMW3LGdQS4hORb2DQB4S/yZxytolKkxzUny8Ox3e1lsoN9GlD/BFAUvC2cZf4hlFLtVVV124TfVuvz3Yyh8FzJB56dd9DQUwA9obfObBDnziNfXbmzuZDZRKxVD6aG9jIToXydEkUo7K7trFMJFdlx1Tk3lUlOqDVzo6hcOQNDfNZ5rGRinOUJWmp7yd9Il8Tu3GQnt6666MiDY75GgeigwmpppQ+gJtsH5q/TQO+lNK3T8Cc+asXCx8YhGBDgJCV4oyZErPgebrZdC/1AXdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3MpcEjgnI1jwhWnxOdnAGnUWaShIx3pj+C6e5uVL6kI=;
 b=KsQmvq/rSleeuWJkdGi4eFKoNSB53EEGeokX7ieKiiIwkXzPKxFhI2UhpO5DKX0kAHqbb7zxcm6KeFDsynDwpR1EX1xjAWGpMUL8GJzRGCy9HMUwNXKkX8clCOykqD+fR5rMzvSW4ncAkXUjH/3+SytbD1lqw3A7+PZyqF4tc+s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by CO6PR13MB6029.namprd13.prod.outlook.com (2603:10b6:303:140::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 10:04:03 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d%7]) with mapi id 15.20.6631.026; Fri, 28 Jul 2023
 10:04:03 +0000
Date:   Fri, 28 Jul 2023 12:03:48 +0200
From:   Simon Horman <simon.horman@corigine.com>
To:     Ratheesh Kannoth <rkannoth@marvell.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        vladimir.oltean@nxp.com, claudiu.manoil@nxp.com,
        alexandre.belloni@bootlin.com, andrew@lunn.ch,
        f.fainelli@gmail.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, olteanv@gmail.com,
        michael.chan@broadcom.com, rajur@chelsio.com,
        yisen.zhuang@huawei.com, salil.mehta@huawei.com,
        jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com,
        sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
        hkelam@marvell.com, taras.chornyi@plvision.eu, saeedm@nvidia.com,
        leon@kernel.org, idosch@nvidia.com, petrm@nvidia.com,
        horatiu.vultur@microchip.com, lars.povlsen@microchip.com,
        Steen.Hegelund@microchip.com, daniel.machon@microchip.com,
        aelior@marvell.com, manishc@marvell.com, ecree.xilinx@gmail.com,
        habetsm.xilinx@gmail.com, peppe.cavallaro@st.com,
        alexandre.torgue@foss.st.com, joabreu@synopsys.com,
        mcoquelin.stm32@gmail.com, pablo@netfilter.org,
        kadlec@netfilter.org, fw@strlen.de,
        muhammad.husaini.zulkifli@intel.com, coreteam@netfilter.org,
        ioana.ciornei@nxp.com, wojciech.drewek@intel.com,
        gerhard@engleder-embedded.com, oss-drivers@corigine.com,
        shenjian15@huawei.com, wentao.jia@corigine.com,
        linux-net-drivers@amd.com, huangguangbin2@huawei.com,
        hui.zhou@corigine.com, linux-rdma@vger.kernel.org,
        louis.peens@corigine.com, zdoychev@maxlinear.com,
        intel-wired-lan@lists.osuosl.org, wenjuan.geng@corigine.com,
        grygorii.strashko@ti.com, kurt@linutronix.de,
        UNGLinuxDriver@microchip.com, netfilter-devel@vger.kernel.org,
        lanhao@huawei.com, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, shmulik.ladkani@gmail.com,
        d-tatianin@yandex-team.ru, linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH v2 net-next] dissector: Use 64bits for used_keys
Message-ID: <ZMOShFGhiZH/vory@corigine.com>
References: <20230728022142.2066980-1-rkannoth@marvell.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230728022142.2066980-1-rkannoth@marvell.com>
X-ClientProxiedBy: AS4PR09CA0005.eurprd09.prod.outlook.com
 (2603:10a6:20b:5e0::11) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|CO6PR13MB6029:EE_
X-MS-Office365-Filtering-Correlation-Id: 21e637d2-e9eb-4f83-06a7-08db8f51f875
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yeOuX7dtZkK+4ePWDITokVqorgXZZpbakVe9jzERYuGC7OQNKjf7+ryAxA/Y3tceIwSVfGpYl6e8b0KFQKkLNj2KjIbBc42VJHFGUCJn5KnzEkRg2DL+nGIHIr3VYyT7hsMJASrT4DEBnAagyrsI72RtK75aykyJPMeUunjoamGloTx5FrUFcM+hLg7lxOE6DmY0zMnwqZoJYjvmdzyN86EWs2dQ+GP6GREvnF0XqAMu9rQnlAwPHPTrC36nAxonJBL0hwCrRDi/zSMl9MMcXfjnFbaycj2M57cAbOSu+lJFiJXq+TNLVHdWM6EiJXof/nIBUBbYgjVqgM/wojOiYtzm5pciWc8Hnn82x57vtnwH1mCw+a7ng2KVnVZyv5a4reueQeKXH/QSO47bI2sjGnhDnNuC1ETNDZpUDwKZtbPE/QFuh80dkOGOwUexUWYE+PpgTVDwD1g/uwSwiNGjQZINhQQhBWw44sqCeUQtXNItUcc3EqGs3Pw8oTEbRpc93e2TDnqy1Qb39Ss84dn12zDkH1OoFgNzva81wiD6uE2zWs3rCg2cFQpHxi+ojeroMWJTiwLrTHbwldcoavQVFXFuuFuPhj8K3V8ABs/Sah8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(39830400003)(366004)(376002)(346002)(451199021)(6666004)(6486002)(478600001)(6506007)(6512007)(966005)(66556008)(66476007)(4326008)(38100700002)(186003)(2616005)(66946007)(6916009)(7366002)(7416002)(44832011)(316002)(86362001)(8936002)(8676002)(4744005)(41300700001)(2906002)(7406005)(5660300002)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MznXhqW0WXcIiOcORdAuzR346RRmsy7VrcDOGTsmWQZcKglS6it3+GlCzDv3?=
 =?us-ascii?Q?hMWfFbbEqADZWuWQtUFtXTO8LTCXz/EFTTsdmxB5DpuJGFRMrESPUyFQ0ff0?=
 =?us-ascii?Q?Dc5Pt/cRi7h/aXq3DzIvnvTbLBlEp0MRt6hCG6neJAeMIIFUiibrp9u5PL0Q?=
 =?us-ascii?Q?3pEU7zUg4G87uNCqcl1k+LzdCt6tZoLwn80YKBHPT5BYQ7Hqm/klNxbdfLZl?=
 =?us-ascii?Q?5cLbvkeOl9ToDTSX7Ic9843FgtUZBMK7dtXaSqM33u9nh34IMsXiAMHpUrA/?=
 =?us-ascii?Q?kO6ddLTzQR48oT4q6xrgixFfR+R/Hzv+CNUGDhIVv9F6s5Xyy5WGZRnGs4VY?=
 =?us-ascii?Q?3xNVtCp3We6F1kNuj1w0wq9T51o72G+tXuXdNwk/YOMan//vQ6zT3FzkOf3U?=
 =?us-ascii?Q?XZ2UWkHJur98gOdjOGjyWlRaE3Qjug5J0ux8jKCRN5qrWw3Y3sfnsi2liDed?=
 =?us-ascii?Q?+hLpQhvkpDHyNHWA8ygmZM06jdXZIJukOfi495dhcKv/HkBcZ9eYaNP8/+wJ?=
 =?us-ascii?Q?IRqAGTHSOcf7UnV3xYzdWy+sXJ/22PV/90cAXg093UR8eCH0YDQUVLXSWe/w?=
 =?us-ascii?Q?Uu8gxe2p5TGGNSGRw9DDy8JuH65L0sWpzPp0FyeXUrZKnZI0B3uBXB7SXcFd?=
 =?us-ascii?Q?oC//VDQX+18YCa2UGKJOcKptHA4K1zAlAMFnhmigh4gkkkd/cl2VSoJRWtXu?=
 =?us-ascii?Q?osf5LL2YxWLwMocy4c2/iot70In+h4UrxdSyI+AmF022sFJEygqfRD8O6vt8?=
 =?us-ascii?Q?9vwnCjxdGKoKB8Drzj2J6OMuAaTvHrZHfSEv8uu87p2Bn7QonQMfagSCOlRF?=
 =?us-ascii?Q?OgRn4P+eITxLpg6tjWGQxJhXHfrY0A03lgH6bscohCKgu8fg+Q+xTsbvgw43?=
 =?us-ascii?Q?f/FDQ43aZ0Rf2ihw6ue4L0Uw3NGTFQ+FUwLdunj/MyXng5ACxTJ5X0okojmY?=
 =?us-ascii?Q?Am3nrgfx5T1fZZMXLlFSWMNSqVQI3N4yEeL5g2s40YjGiS/MQUsoIqg46Wm0?=
 =?us-ascii?Q?42q/DwoXQ6UDFPOukuHiZ87luGRc7IxEbPaSpRA3mxdGiaF7Dp5ELFXOpLzo?=
 =?us-ascii?Q?6ybvl/NRbClLRqfQD9VnqjywToWF9i91MtFErSuPfOY1zYO+eeuHoeWfJzES?=
 =?us-ascii?Q?hOl3/IDz+7tTzajXe3DUlvnN63vBaAOTvpvBh3/4muC1w0BjsNC/uLiXifzb?=
 =?us-ascii?Q?5rw8csjgt1hkGUYqNt5BUSXlxTnC5AvoQ3PFRZtLpfc75ODe1ESq6iHjXv62?=
 =?us-ascii?Q?6R2QiBugm3zw6712axOBMHwjC2VpSIx3w9fnJFkVv6XcIfT8dmjoe+jK4Tv4?=
 =?us-ascii?Q?B2LHUaaayGZ2oSgyGcDmU+Uw0J1X6ZYa7WBrvAvLRjHxkBOsYiKHPKWRqlwh?=
 =?us-ascii?Q?INJLAVeWSJe5SmbLEOWYvjwpMr8OAC2o6/ROeGeugkSBHNasti0yefQZ4G2x?=
 =?us-ascii?Q?CLmlw1j+jOTwUpjymugBee4fj2fIKxGXM2wIMHFqXhjr3ROVpVcU+XbzDlx9?=
 =?us-ascii?Q?hAPYOrYYOtrgZ2DJRLK87ptEEMpg4FmM/dn/vC+OKCKWbcKBzkZdwiQUGI4i?=
 =?us-ascii?Q?XT3WmatNkixC9wufP6f48rCsRHxbhBXmd6VSXLK+4mS3ZFGVRDATGkGD10pt?=
 =?us-ascii?Q?Q76C6uTL7YyzhuZWdhmQJvBjOPU1aXX28hC5mRq8JVZ08e+zRynxsHO+cHqu?=
 =?us-ascii?Q?WlkuSA=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21e637d2-e9eb-4f83-06a7-08db8f51f875
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2023 10:04:03.1105
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XJ5YE4gqrnu4rP7+l2n8j/enWbNnRbeid/U0FuTptCQAUnzAm63AaH+fKa5wTSmuKOXF9qGQ6W/Q1eJt72OMqK84dnK9vi4ljamymfiCMMc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR13MB6029
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jul 28, 2023 at 07:51:42AM +0530, Ratheesh Kannoth wrote:
> As 32bit of dissector->used_keys are exhausted,
> increase the size to 64bits.
> 
> This is base changes for ESP/AH flow dissector patch.
> Please find patch and discussions at
> https://lore.kernel.org/netdev/ZMDNjD46BvZ5zp5I@corigine.com/T/#t
> 
> Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
> Reviewed-by: Petr Machata <petrm@nvidia.com>
> Tested-by: Petr Machata <petrm@nvidia.com>

Reviewed-by: Simon Horman <simon.horman@corigine.com>

