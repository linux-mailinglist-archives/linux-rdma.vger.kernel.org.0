Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03A8C6119E9
	for <lists+linux-rdma@lfdr.de>; Fri, 28 Oct 2022 20:10:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbiJ1SK3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 28 Oct 2022 14:10:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbiJ1SKS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 28 Oct 2022 14:10:18 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2069.outbound.protection.outlook.com [40.107.92.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3D3122BE9
        for <linux-rdma@vger.kernel.org>; Fri, 28 Oct 2022 11:10:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hn0QRLEgYI2JGHndb1tm87Qv7HZFXnOHIcEg/b79U63ej7IpMipDp9B8I55YnsYqo27qIGg8PzB2EKDVjSks39BriiLfTpBnMSMlw2Nv8uOaSVuvt1i5Ygh6x5usBFCiO+mM14ApCx26IH1oV2DxXD9m0r1Mun7glvvh9zrCeBfOZNvpg3LYgRm+VDfF5xWfsn7tfiv+HFQACmMATPSeVD7jWgzLMl600Sjw+snTGWZWg7YZpczdjUoIvAejT/PzsXA3AAGJM1DXAftMR2apuAu5e0jAPVgOxGHYQUW5XfV6d+xZHb2p4ZieU41YCkVyxz0n7K6TjZ4kgzla705+pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EbLIC3aBAH0CQPgtwExHuxOof88rNmDlfuaskKV5iDg=;
 b=CVpJZuV7D+tL8EfQdOwz7LzCjsk2/tyeHTvhw1FLlxshTvwAOVRtORWCeKvJuf98wIxrx643Nk2ILsIQaziWavUrBkKfmGnafWokgCGz4IvpFKNTvxRXCCK+e4zXKXqHhvd8lq0fl4rm0F0p2xJj1d1Dvq7nwfp6fZw3mHJMJWM9W3U1zMfbbLv2DnDPTofSOWMMN4VlXX4RN0syAezyRsEAbJfvY+yPzX6X50l7Uvy9gzTkils6niUcnsvEnpvIXEgrrtmC/VRXP498jeL84GwrV3M8vRKMqpPPCb0Zt3rCboHkA5Dzv37n2cxz1BKkrDu1oGhuh3ljptPY+ost2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EbLIC3aBAH0CQPgtwExHuxOof88rNmDlfuaskKV5iDg=;
 b=gCg74+0sf7lzMLDjVzDVl2yXzpl9f5rcMAg6i+aFn7njLIjrliT9qln96LSJQKBPO8nVAI6FnbRiHpA0iAbCpSoLZl8+MwxgVg1f7ju7cy90avwbIkwSZaC7PgcwISwiKbtwNoeiPWzNyFjIGf8MKkDqZbxnMVr3pDFeZJCZ+L4kQQ+INdBSCMQ219hrPF+K9D7LYv3ovpP3PR6y1pOOYAmBpfr0Hon3ARA3gqQMIkMo0DcIE6O8X+n5U/gLInqQBg1aqPScaAYjSxxzSnFG0GCiTP8iJjNnCduI21+IZB+Y5drvc2zyNisBdLTzgAfTuvUcuv6yA2oIdiQ2Al7pMg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM6PR12MB4895.namprd12.prod.outlook.com (2603:10b6:5:1bc::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.15; Fri, 28 Oct
 2022 18:10:12 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de%6]) with mapi id 15.20.5769.015; Fri, 28 Oct 2022
 18:10:12 +0000
Date:   Fri, 28 Oct 2022 15:10:11 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Xiao Yang <yangx.jy@fujitsu.com>
Cc:     linux-rdma@vger.kernel.org, leon@kernel.org
Subject: Re: [PATCH] RDMA/rxe: Remove the duplicate assignment of
 mr->map_shift
Message-ID: <Y1wbA75eyr0EqRxR@nvidia.com>
References: <1666855893-145-1-git-send-email-yangx.jy@fujitsu.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1666855893-145-1-git-send-email-yangx.jy@fujitsu.com>
X-ClientProxiedBy: MN2PR16CA0018.namprd16.prod.outlook.com
 (2603:10b6:208:134::31) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM6PR12MB4895:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b8bed2a-b4d5-45de-6e7d-08dab90fa7f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 46+FfoAZR2Tkr6DBemMWdBItoSbQmXQ9LHGDA9I17aaNvIZVGQ9OG/tLI8wkoFvPMC3J+fc2iFEMCj3YHLG808A2HXFX7JUMD3JUpo9/+kkZMKuITkZqE8E+2G0Lq07/DJetv5JJrBB1sZ44sYvTefesqUeKc3wyuMSmKcZtUoON1Y8RAQZZT8xGneR48pYQ8RqQZxqKXAFtOr/yaNzmaNDXh9mhdAUzAtWa5OUYvWufWq2sT9SGs8Ao5TEIk7a+n7xuUUvfqrSwrd00aM4x0zg+bfc3seYshjmOfR46pqr1c8OGbo9dkD92EtYfba0c+2fTRRqySE4VCUsP7eo7Eu3rTW0F0eazM7SixVR2MJC8k5lz1qn0C8Y68i2b3HHHCUKFrsbtd5YTlZ5HPCSkA/H/y8q0WSZk3+jN2dkhVeFOEwjhYv+t3yS+2YSdPAg59OgDYHYgIx3aORDlKywJX8f6NUgiHokd1MyO4uHp74X+aR7EM4Q9AsP2JrAq6tB3/OKzi8Ivo01AhhVdYSqEwI2TQ1A6ucqvHG1CttR6F8YADdJxPkGY82FyxoBqBfXSGq87709kKsBSh9TVGunnzyxrqPDYMYGtO9VThuOdXviQkT/PkAlr7z3RwdMDhbjovpS4JGxsF9a+CoeW7IymcMPSM2Hzlc6xyq1bOpz/8ZGVoiaQkvz1yPJ2prPJIiIJY+6vsQtcH1mwb4iL9LdfSg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(136003)(39860400002)(376002)(396003)(346002)(451199015)(478600001)(38100700002)(6916009)(86362001)(316002)(36756003)(6506007)(8676002)(4326008)(66476007)(66556008)(66946007)(5660300002)(186003)(83380400001)(2906002)(8936002)(2616005)(6512007)(26005)(4744005)(6486002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LB74G0iW+DDq+BTDQc64CPv0Xy4FTv2rTfZ/XC7Fnq2WCmHgOG4iHM5iWwcy?=
 =?us-ascii?Q?RnNEiWNObrw2rzP80V9ENLAh8zXjhdVs3nVHE9gTS8hg45TmxFnhoVIA6JEO?=
 =?us-ascii?Q?t1QgIy7IzBM25jdbw0+25Xw2ZcJPNKsiRikuAeSXBQtIS3mDOeU++syNG1P7?=
 =?us-ascii?Q?+bRVf1kyy4Ru48DGncVjQaVwwXWMhIOpUGWdWpZevwfagb4hfgDBRc73VoAA?=
 =?us-ascii?Q?5Is5qVwUjo1S/YTL94npkJliNzi/bI+3ITlCYROnXz5U4Bdc+VyIFcTuPbT1?=
 =?us-ascii?Q?SN7sbga5XQ7jt2NiYKSEpFE5ZRujOWOPvWFW6GwmUzNKXYsCZZXYOPICwBrH?=
 =?us-ascii?Q?pgU3cRV1CQOorSmtZkL0sAP9z8XozKeYJViAZg6cG2riSsuTcaaoQQObqI9p?=
 =?us-ascii?Q?E+0sgMpPEk92H//HUYYFEVBNXmsAqvsCwPbJR/1Hjw4CfCJoLuoOlVQ45KJ3?=
 =?us-ascii?Q?WDNfcCUKZ9gAQT6m4WOfAF62QSw9OIogjkvN/AP/lnb/ILnUYzgqzRk5Pit/?=
 =?us-ascii?Q?mmagAeU3utLdCJQx/45lJduJBEfja5YO3Akn4wQe7zTXIfchzP9NFt3+h+Lz?=
 =?us-ascii?Q?rKdeuNYXFncnzeQybDEThcStTFXDXTJtrxNSh8VYUGJvX60Il7UN4FJoyqKt?=
 =?us-ascii?Q?zUy3hFN4WUapiWes4GpL+08FM95jWbdbxRgucUNGfd/P00k+OXbI5tJCNK+V?=
 =?us-ascii?Q?aPeA976PPz1Q1s+pXo2j96q4txS16O1BEVs1IrTWSqF9K4RcNZqosOqxFWbw?=
 =?us-ascii?Q?/oGzTKQjEi1NSabXf9O+1n6UvfFR/w2VCEdj4r5m/tpr3h66MPRiXK7R6KUT?=
 =?us-ascii?Q?6RnB/ONvkJuuVphT/V2Zf3mFoun+dENHJUmonscL/js0kdv1o3/Ioowqa+eL?=
 =?us-ascii?Q?gpLemYvilSqXQmNCMPu9yzmk6jSj+ERuA8CYuqPTpsD7ZlF/ykIYu+1KtCWO?=
 =?us-ascii?Q?TTdhWFhyVSvhHl8RTXxh0N2X4Ghuqo3AAIFSXk0lyHpUjYdxJmSlCophz4im?=
 =?us-ascii?Q?dPb0aBPS6VkhR4sxrXiHh9I/i2PFCGUCh9hq8g4kZS9f9LwapV9LY/Ac4ElA?=
 =?us-ascii?Q?EiNmESPO/jKsWLPtVPC+b91OMO5ehvkJRO4D23bTCRuKp/9WTBv2waGwAnu/?=
 =?us-ascii?Q?714A8jbiEaFMMgTvO+GOgi3bsgJsp0zY3/BkqO+LCzZZGZnZryPdDRAadl6x?=
 =?us-ascii?Q?Byr8fgLJvkGyZZgBnchbBSQ40Bcm0kSRqzntaw9h+MXchPzbOUe4z5LMFDDL?=
 =?us-ascii?Q?fqos+aofYcdAiFn3RiQmXuONDlNhniq/3v+iSeuCiG+Wifm5K37p7Ik2pean?=
 =?us-ascii?Q?mhBR7KR57X0YTO+GbYwa5cO4oFyxyOKTGq1XGh6s/Nhq4mDFBP0o1X3bdws1?=
 =?us-ascii?Q?fN7fmzFjrtfJWkRrrizoqGxmidHJgRteHViTXpQVlfERQCRrh+/gRqNfVR6u?=
 =?us-ascii?Q?ZzWK8IF/TNyEEJ//fdvIc04AKSp0jgmtAIFy3hplHze7dQ7ulYHMq51p7+g5?=
 =?us-ascii?Q?w3SsfwG6CcTvQy6KzfLK1MROtR9Nl3+XzM/f+9ZjrHeEhq3Rfp7QWrTfqu/E?=
 =?us-ascii?Q?qq+8e+MatXV2TKbI7iQ=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b8bed2a-b4d5-45de-6e7d-08dab90fa7f4
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2022 18:10:12.0901
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xDucm0cBatDWunidPmd4sHstNsYbQc/7wLDPFiwszrARYUD1Q1aov/yZcXy8E4ei
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4895
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Oct 27, 2022 at 07:31:33AM +0000, Xiao Yang wrote:
> mr->map_shift is set to ilog2(RXE_BUF_PER_MAP) in both rxe_mr_init()
> and rxe_mr_alloc() so remove the duplicate one in rxe_mr_init().
> 
> Signed-off-by: Xiao Yang <yangx.jy@fujitsu.com>
> Reviewed-by: Li Zhijian <lizhijian@fujitsu.com>
> ---
>  drivers/infiniband/sw/rxe/rxe_mr.c | 1 -
>  1 file changed, 1 deletion(-)

Applied to for-next, thanks

Jason
