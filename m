Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03FD7642E6A
	for <lists+linux-rdma@lfdr.de>; Mon,  5 Dec 2022 18:13:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbiLERNF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 5 Dec 2022 12:13:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbiLERNB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 5 Dec 2022 12:13:01 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2042.outbound.protection.outlook.com [40.107.94.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D27F71AD90;
        Mon,  5 Dec 2022 09:13:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=flnsm4AL09PoGR+utj0Yd+gHPuLMHzQI4H6q5qK5eu7DCbg1DI7yiQQ01dpTxZfgrP7qpiNUwzElU08q/zSWbgrDPtXveyn2/Pnw7wLN8aL5EDPPaJ1TpRSt0km3Yq0jF5EWGAyE378u7lnDSD6mF6UvnhbWpqz95feTJn5FkxU8b0KHpL+br1LlkSBwYkYhjUpez6uMOqLpgLBZZYVReV8JmIwOiIqbS7tlVeQrw+WMbXRYSPABhLh/6njSc4AVZG88PPdyWdw8hIeQZdqPCMOWmVXPYhWm31BpBi1Pl9SK7Pq1VXB9WbCNfnOoDO+Pb/xitEzM36pkWoQrUCbGIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LxTVL25kOsqwhKvlOtqFqGxEcMQrYAHWiR8tobah/Gg=;
 b=TyjNsM8aqYJotQHTIzL2egNZIUbuuoj7Eh8OsrAN03YqCUcSBtDQOV7lEyHvTbEdtP8ag5sqHPW4BTUzaGmpkHcwrl+kwQMArTLBltJvOXNoxeOeaSiGNB3ISDwHUKDT/tKMgPzwQ27Va7P1mYPIPu+xyIPdMUqGq53Wa70HYSQZFnMQaKz1Nj8A8Z9A12Wfk8JwFOVdy1pfhL2osBUsl1z1uiulz+RYOBN1RV9+OYjOJHht+Gu2EVZLWjeXPWROyiMxqk+Oah9Lw4JBhEVd2QlECLgnBNlDV5zrDuopYx4iM/PE5qHFS2U7RzihiesXWfZOn845QHojSUU5pugKQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LxTVL25kOsqwhKvlOtqFqGxEcMQrYAHWiR8tobah/Gg=;
 b=Q4HU2FcD/ouihUgFLV49s7k/bsKFOskUuTQohEyJzXS4iqRbCcgL4ehFP1PiG/iy6eK6ik+FNN6vpH8XbaSlQtGyTckaO7cGQM2LtYiIpgpsMiXzq4SwIuBYWNkCxlD7hs5NlKwwse2F6YsXC9ehRn/P+/van+siaum7sRkAO/iJQnbsDImM/ghQHf3njV1QuXRUSE8+eHytoLQtaXvUxIQzsh0yYL4q83yfSBS3DrjnmyxHwshKSVG9+qu3Bj8//dwp3qA3QeUlxh6s7+JEiXh3MeXiJIS5P1Lp04Bl1U6rJDIP1GMcravunC5u3ACj5mcsiAIS4XfgbXChKlYpdQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH0PR12MB7789.namprd12.prod.outlook.com (2603:10b6:510:283::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Mon, 5 Dec
 2022 17:12:58 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%9]) with mapi id 15.20.5880.013; Mon, 5 Dec 2022
 17:12:58 +0000
Date:   Mon, 5 Dec 2022 13:12:55 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
Cc:     "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "leon@kernel.org" <leon@kernel.org>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Mark Bloch <mbloch@nvidia.com>, Tom Talpey <tom@talpey.com>,
        "tomasz.gromadzki@intel.com" <tomasz.gromadzki@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>,
        "Yasunori Gotou (Fujitsu)" <y-goto@fujitsu.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [for-next PATCH v6 09/10] RDMA/cm: Make QP FLUSHABLE
Message-ID: <Y44ml2qsQkx+QNRs@nvidia.com>
References: <20221116081951.32750-1-lizhijian@fujitsu.com>
 <20221116081951.32750-10-lizhijian@fujitsu.com>
 <Y3ziLoRuXFIOpnnl@nvidia.com>
 <9cf2a1c5-2334-dee8-8374-63453e23c5a3@fujitsu.com>
 <Y3+sb3RZkEO3ISpW@nvidia.com>
 <a3a10e6e-c75e-853b-06d3-ce2f67424afc@fujitsu.com>
 <Y4DOPjDKM64ryuP3@nvidia.com>
 <3c84d3ca-88f9-0995-4c0a-2b5dc69670b6@fujitsu.com>
 <3d2b0f6d-6214-8d04-8356-852c34563501@fujitsu.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3d2b0f6d-6214-8d04-8356-852c34563501@fujitsu.com>
X-ClientProxiedBy: SJ0PR05CA0181.namprd05.prod.outlook.com
 (2603:10b6:a03:330::6) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH0PR12MB7789:EE_
X-MS-Office365-Filtering-Correlation-Id: c6a44709-c7b0-418e-5b10-08dad6e3f4db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NsxGOHOzUyHZ5gqc1CgBVHJSHtCjGlnuyYYJrhjVr9SWHmUJ+pP24r97mttk648TlIn4UAAbZJTSrbb2suFYMQjVwDvqTLR+oNnxq2nqsotyzzraOM+93Ki+wJRiVVqT4MNAjsMnvOGxo9yOTwH+zEAPjJ4FwatrTK5EfB072SUE0u1wovPjSVCywr6cMGhAk+wq2Sps7DORMURyfggPpiDp4SC3daWS5lNatRa+wyip49m9U19QsK23JlfFbTm5gjPRQuLfmaOJQUEvdmUD8mcFUIr99WJXjkhN8rAm4s9J291Q5cl/QNPywoHNplphRLg62evY7HNLikY3h1a2kUz3ByWPV8IgRJWUn6PwHbp2C6rYclr5vQAem7PO3euZGzsEzuYIkmVz6mqWtH2yxATJEcLq9aVWgOuYvCm7pMCJqbzOngFISrIisFzHIw6+Atw6ZR58wYeVUGHRIXt+65vqNj3Ng8o6EidT3VpXUmT2XJ3km9WFyFfQ0bBtqOU5zj8ei4fTUDPTB8gI5YuP9fnji9EgzACQ3eYAqVOI3CA8f8H63banESciGJdKAzEGB2q0Sl+6B0K1HDQI5VUhUcAG9l9AvxrN0BS9plzFcM8+HVDdaxk90N31uDc8Fmzu/mU32dBRtOUwTyq+qqwWkwyHYWCQMCxBsWS+vcRymHiDq0YxtwgrEYMcmSp8GozK
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(136003)(376002)(346002)(366004)(451199015)(86362001)(66556008)(36756003)(186003)(41300700001)(66946007)(8676002)(4326008)(2616005)(66476007)(8936002)(5660300002)(7416002)(54906003)(6506007)(6486002)(478600001)(6666004)(6916009)(316002)(26005)(6512007)(38100700002)(83380400001)(2906002)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?p5C5eaLS303eTz07AXewdSZ1BRxr692TTK8sMCyII9/BPrkexd5W+PxE0Jp7?=
 =?us-ascii?Q?Zi+EmrLdQ1SehQUYPolTXUE44uzUK6nwM04DEgWg1/pmv7DcHd/Q/u48pXnf?=
 =?us-ascii?Q?HAjmsWRc9tlDeCepJA0m+s2WUYDbM1EMyzK7rKldyfersdLYK0PgX5w5LA5f?=
 =?us-ascii?Q?xqr/uZPTIWISe1wdgxhkcOegerX3eFMjw+k9tA0rrxwbVqBLA/EHbqaSP95o?=
 =?us-ascii?Q?mtx0yfsdEpX75nE2CQzoEtXnVHicFe5bFNiZheP+l/X9so4H5NuyLdkhFxqG?=
 =?us-ascii?Q?i5A0umWOiO9qS1+R2649ICmk1hC7F/A9sYm9x5sh0bRuCHwj9skdJbf6+D+t?=
 =?us-ascii?Q?kWkG+ohXmCNaovQTnXq7ipCvlC8QlKExFTX8IUdulEKPTB+4okEmV/VUHFDA?=
 =?us-ascii?Q?6Swo0GPzy12KfXqarOAwHZODMyZuaNx1z2VEZEag534fjNefw14ICq3hWJUm?=
 =?us-ascii?Q?mVWNVrQMhSN0rQ/gJHqBR6lun9LIcXSzcNB2hKv2oo8DV60wxh6lhdW7oa2h?=
 =?us-ascii?Q?ISrGTpswKqHavLmBNODyK7IloSc0UmECPYH/jtr+McQ8Wwk00nN0BnZipwfU?=
 =?us-ascii?Q?N4CfwDi7TSdRkdsusXFstVt+VURxiqRg68ooKhyLVJ/gfhyWxq6v8dD3yJIe?=
 =?us-ascii?Q?7fJetpmKxwNoMBFHtC+TNlLK2WU35otQgtjGRyiNLCgFZTB9eFmsDwJxBVg3?=
 =?us-ascii?Q?aWRcfDRCGGydg9ql5Q5dCl12M4N9ek8eITBdNwxU2rALEz9k3YLgcSBiprcB?=
 =?us-ascii?Q?eggLRxParFpkP476gk8vP6FFhvohz1vWWEFte7NvkRM27Vzl1rTPB2HLApqn?=
 =?us-ascii?Q?h4jlJ8hkREOm9zRV/NWFgkQ4MxkUw3mHePI0moqebzw1LCnsT0ipJumG0qd8?=
 =?us-ascii?Q?QAjFkrfW+yUgcxoPPJIOIiiiHbHfc8xa8dT2GCBFBLtuFQbvVKkeNzniQnsb?=
 =?us-ascii?Q?Wefu0JHR0NZ3Tqb2tnoXyvYMChF+Qa0tptsMICtAypTqvM3RVCIYKujvekFz?=
 =?us-ascii?Q?dnUpVL01NIGSd8YpCStX+M4yll9d16P9IZ4lF8VFb1uZdu9lYCwqtqZUhnFd?=
 =?us-ascii?Q?J4ec77xyvXWTO51AasRDgfSF5KiZB7eg8ZkAYM3agAeWmFc5whDAI+gK1UQe?=
 =?us-ascii?Q?/V8WcUXJSxJdamQpQY3bNuIFlltUviq0nj227uuuGnSyr2PIO8oZKIWWF9qC?=
 =?us-ascii?Q?0/FGe5DlPeSCBpKdL5wR0SbxIHJB8XeT936Pewfi+H70CisAcy/T3du6T/Lz?=
 =?us-ascii?Q?yMTuwYwACU+y79js84p6WopAvFrL0VNT9EXyZrgTDF01UvP0ZDaPblQgdw1a?=
 =?us-ascii?Q?P5tp6+xWb4l8JDJrwfffh0vJyUhGrljrdy2SJ4DTKvoQZ+MTdO3lXjfKVSXn?=
 =?us-ascii?Q?xcCb9fhoPy/xCllp18gn5+4MW/fx6KLMPXtu8sCGNLZjs2hcP2hAg/pgNx4q?=
 =?us-ascii?Q?+GAjU85AhV61j/uSSmynR37DoiGdWZgZCRw42sGCCzAE9g4Kyz8yaRbe1/Vb?=
 =?us-ascii?Q?axlP5d9yK/8BhZHe6gygnY5CmP3cw8QDSoV7oij7gkZoTZbo5zECY2noHPVf?=
 =?us-ascii?Q?DLOO9SMr+LDnYP93AaMYMfi83BIWRbD9WNFE/NWv?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6a44709-c7b0-418e-5b10-08dad6e3f4db
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2022 17:12:58.1220
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vq84j57DIg+00rtNrnegYd4cE/bzd+uUq2argmg7wYLscFvhf2GEozhX7jr2K7Th
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7789
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Dec 05, 2022 at 10:07:11AM +0000, lizhijian@fujitsu.com wrote:
> diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
> index 1f9938a2c475..603c0aecc361 100644
> --- a/drivers/infiniband/core/cm.c
> +++ b/drivers/infiniband/core/cm.c
> @@ -4094,9 +4094,18 @@ static int cm_init_qp_init_attr(struct cm_id_private *cm_id_priv,
>                  *qp_attr_mask = IB_QP_STATE | IB_QP_ACCESS_FLAGS |
>                                  IB_QP_PKEY_INDEX | IB_QP_PORT;
>                  qp_attr->qp_access_flags = IB_ACCESS_REMOTE_WRITE;
> -               if (cm_id_priv->responder_resources)
> +               if (cm_id_priv->responder_resources) {
> +                       struct ib_device *ib_dev = cm_id_priv->id.device;
> +                       u64 support_flush = ib_dev->attrs.device_cap_flags &
> +                         (IB_DEVICE_FLUSH_GLOBAL | IB_DEVICE_FLUSH_PERSISTENT);
> +                       u32 flushable = support_flush ?
> +                                       (IB_ACCESS_FLUSH_GLOBAL |
> +                                        IB_ACCESS_FLUSH_PERSISTENT) : 0;
> +
>                          qp_attr->qp_access_flags |= IB_ACCESS_REMOTE_READ |
> -                                                   IB_ACCESS_REMOTE_ATOMIC;
> +                                                   IB_ACCESS_REMOTE_ATOMIC |
> +                                                   flushable;
> +               }

This makes more sense

Jason
