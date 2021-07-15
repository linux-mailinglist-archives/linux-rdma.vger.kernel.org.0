Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBA6E3CA4E5
	for <lists+linux-rdma@lfdr.de>; Thu, 15 Jul 2021 20:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237067AbhGOSEH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 15 Jul 2021 14:04:07 -0400
Received: from mail-dm6nam12hn2208.outbound.protection.outlook.com ([52.100.166.208]:59489
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237201AbhGOSEE (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 15 Jul 2021 14:04:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XYDXz2C6oo/X+kXGLQ4epjuUVJitZ/woKCwLC5aEv/CUjr+v06AntQKORd3LGzQTTLlNxmcFmLD71t1gGex98v6ZBIWWP9FI19EJcH+M8OBxJltaCogqhHdk2boPlPS/NSORYP4EzEc5qRlrTlhzLi6JGEHQcIzsOtGkKVAJClvYMErcm/CbaNm5Eyo4Me2OCus2yGU3QTtTGefWsMCYMNu3B6tojavVQqs3Bm5IXeHW9Kj8BdJ2a0soLI1bpup4E8kJs8S8Akg49ynpwweqc07fi5US9pib2zvD19L7ljLHovmQ60ND/lizbgiqUuG0CSNR895AuBnWF/VJJJRTlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CrFHu9d0tr6OCGqr4m2P2C8DtaHX1YzYhzaOGCGnGrA=;
 b=YJ3n/RFiruYAZQ+tEqQn+2Nh3bMAitOFFbfMinoexXnhuFLQncpijVgycpik76UWzdAYJ4rgSmFr1fZULPqAdoV8cevkY8EWN616EwPo8iES1XpcxRIC6cWieCk0F7jYOxVh/Vz0YjwPh/jFh1vkFfpqTZMmGPUNXSkvyh3EHLRxIVphqM6jp9mNP2/ruCUT3rMYs0SHZS+dCHWLCqE3JLMFvFZ/mdpGlCIyh8cSuZ4GIQ22Iqs6lPpyDHVPq/hoYX7OIFiWNYMO2DC7rpr5weNEzM5vsgn6pTUZk3KrJi5vRPpnHLP9nhmhhYv8wMBN8d19rQr4ekApfq3r2SSvMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CrFHu9d0tr6OCGqr4m2P2C8DtaHX1YzYhzaOGCGnGrA=;
 b=pI18m12T7N2nNB1In9bOO6PwZ1n3tzAv9Lo7KEHcPJxHGDc4b3wL+tPekFnQl5VpbVDZ6yCJsYPT9eJy/CBlDjynCosIfgLJekaJu5KFC6bVxmOsr7ZJEp73XFl1TcUhpf0QKoaBj3p+Oud05zd7r1HbL+LC2F3RtXQx5qi4GsL+WW5eazCX7ug0W7dvcEXFto1Ym2RZWuprOxR0NUm7fjmi1NiaBNli0n6gfVG8ixZic+ugEgqjG121u+fKPEFDaaAp7dGeWpUSo+wiAxGfkuBFRo/eG60TgQPB06QXtDVpsyywdd+vNI0H3AJYbvLYyCIR8yPQd65Sssld3nDZnw==
Authentication-Results: 163.com; dkim=none (message not signed)
 header.d=none;163.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5191.namprd12.prod.outlook.com (2603:10b6:208:318::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Thu, 15 Jul
 2021 18:01:10 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d017:af2f:7049:5482]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d017:af2f:7049:5482%5]) with mapi id 15.20.4331.024; Thu, 15 Jul 2021
 18:01:10 +0000
Date:   Thu, 15 Jul 2021 15:01:08 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     ice_yangxiao@163.com
Cc:     linux-rdma@vger.kernel.org, zyjzyj2000@gmail.com,
        Xiao Yang <yangx.jy@fujitsu.com>
Subject: Re: [PATCH] RDMA/rxe: Remove the repeated 'mr->umem = umem'
Message-ID: <20210715180108.GC667398@nvidia.com>
References: <20210702123024.37025-1-ice_yangxiao@163.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210702123024.37025-1-ice_yangxiao@163.com>
X-ClientProxiedBy: YT1PR01CA0093.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::32) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by YT1PR01CA0093.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2d::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend Transport; Thu, 15 Jul 2021 18:01:10 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1m45fY-002neC-1v; Thu, 15 Jul 2021 15:01:08 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 247fcc43-3c7d-4b46-808f-08d947ba86ca
X-MS-TrafficTypeDiagnostic: BL1PR12MB5191:
X-Microsoft-Antispam-PRVS: <BL1PR12MB51910D9F79F4A5AEAA7110DBC2129@BL1PR12MB5191.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cDVFTi9XM1plK2FJM0w2Z0xTbm04eDc4R0JUWlAvV2RMRlgxT05EVWZHNHI2?=
 =?utf-8?B?SnhBdlBFc01XbTBjQ0tiOWZJeXNnMlhZcXNNMjNYSUFkcG5mTHJmU3A0NTU2?=
 =?utf-8?B?MzRWaCtYMmhVZWIzeUlWd0w5ZzZJejNjTTZJVUFqRUs0aGFJU25RQlBUclB5?=
 =?utf-8?B?L1NtcFZWNWpRRzBBMFRRNzk3cjUrNXM0ZFE1N0h5eXZROWY0dmZSWktNVHAx?=
 =?utf-8?B?UzdDV294THNhcFAwSjZDVmFaVVQ0YUtHSE1VNWZrVHBnZEE4S3poMDFQb1lQ?=
 =?utf-8?B?V0FuWVo4N0MwZHkxYktWK25RbDJsNFg1MEVXSWJCQS8yUVJQMmtjNVVqTWs2?=
 =?utf-8?B?RG44NGI1S1IwY2wxQ2tNeXpjTkN3TmxqbkxueUNienF4dGc2WFMxT1Uya1ZX?=
 =?utf-8?B?OEphSEZlSU9hbFF0R29NUzlJSEJXRm1CTWtSUXlKWmoxZ054ZHJLZEN2d3ht?=
 =?utf-8?B?V3BWcUcrRGwzcEp0enZjWnhPK0Q3NEpaTXIrSGlONHk0Wi9qUDBZQm81bUtV?=
 =?utf-8?B?UnBLSWJRNkF5MGlzWVNMd1dJd2tjMXR6a2NiWUJ1cEFteThvOGFWRnNSTlpF?=
 =?utf-8?B?T05LZmRSYWtpNVJ3TkErUnhmNjF3c3VKZ2tWRkpmU1NuR09QK2ZXRFpJcE9Q?=
 =?utf-8?B?bVJxRHVJZGllcFY1bERESHkrcS9zQS9LNHRpQnBoNjM1UkFtMEZ3bmxZOVhp?=
 =?utf-8?B?a1VDNnoxdm1RbzAxenJUV2E0T0t5SXcwY3kzY0VicnZnUUlka1VVTFZSVWxS?=
 =?utf-8?B?bnA5V1NvM3BnOXdJM3dhYWFhSjdaYmZwR2ZoMmkyS0JzSU02UElYc3Jma1Ex?=
 =?utf-8?B?SE50SlJ1MmlCcmhBa2lyZWRMMzJaVHRTdDluOUJnd0hDdXRxdlM5dUIwRlla?=
 =?utf-8?B?bjd0M3M4U0xOblFiMkpETjRxdHFtVVRZbXVaT2dISWhhYU9uWlRLSkVyR2Rj?=
 =?utf-8?B?WXg3RGpyQ1hiZlZWTWdES3k3Z0NmQS9FdXNDK05Gc0t3WXdYQjJ5VGFwdm16?=
 =?utf-8?B?QWwxTkY2eU1MVFFYVVVoU3NaQlk0akVkK3hFR0xLVGlLNVRXVkovZHJlUlds?=
 =?utf-8?B?RXV5c3VEdkpGT3JsaDk2UTFBMDh2VG1YamhnaWpvbm5XVWpZeFFvWlMzdEdx?=
 =?utf-8?B?VStmdWZvS3pmSzR6NTYwMHdCS3d2TnJSZ1pKWTBsUXlYTlU2TjJhc1hUaE43?=
 =?utf-8?B?RGR0amhoRHVKR0w0dVZpdHhaMU5ycHVuUEtEVnR1NWlQRE1hd29DMDhUckdU?=
 =?utf-8?B?MDlXVHBsVDNkRHdkQXRhaXk4MEliNmI4ckhmZTdxZnh3bWQvaE9LZDdkY0hC?=
 =?utf-8?B?Y2ROYndHRUJ0VnR3OVZXRkp6SVdYWW4wYjI0WHFxMTYwcHBBMWNjK3NxQkUx?=
 =?utf-8?B?VlR3V1pGeEFET3c9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:OSPM;SFS:(4636009)(346002)(39860400002)(376002)(396003)(366004)(136003)(8676002)(316002)(66574015)(26005)(478600001)(4326008)(9746002)(1076003)(186003)(8936002)(66946007)(5660300002)(83380400001)(6916009)(9786002)(2616005)(4744005)(86362001)(426003)(66476007)(66556008)(38100700002)(36756003)(33656002)(2906002)(27376004)(1491003);DIR:OUT;SFP:1501;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RjdLOEo3T3BRaWNmUGdZYWRLenl0R1ZPaHp6VVIvMmZLSDZtYnJlK1FXcGdH?=
 =?utf-8?B?RDRmS08rb2NySUhvbTRPQVY2TmU5NWVsdmVCcWQwU01ralBNcHM3MVNoZmo0?=
 =?utf-8?B?d3JCeVZqZ01UaDQzZUxMYmdXcmcyd0p1L0o2b0YwM3VZTTJnbUdIQVdMM0Vs?=
 =?utf-8?B?UGp4UzZwdzBxdHBjeHpPY01MQkJydG1UY0IzdVA0bzZsZ0pIREZycG5IZVVj?=
 =?utf-8?B?eFpqT2grSUU0T1FTY0h1RXR3U3ptOFo4Mjg1RXM1ZGRRTjlWWU5BWXNnZ0Vm?=
 =?utf-8?B?Q1h0MXl5a3dMOExrSWMyem51RVRRc0l2bjhDM2t1ZHhMZURESHlrWkFQSFdm?=
 =?utf-8?B?cDRLWFBWdFdSZ2owME1jSlhtVjZHTUxCRm5WTGdjWmtjRFZCTkdvVldFbmpl?=
 =?utf-8?B?Z0JhbFNlKytjZlJwUGZyM3FRNVp6dFZqRWZXNk9tazZnZ25BUjExalJzNi9U?=
 =?utf-8?B?eTNNOEZvVFJNWHNvWG1xaThUVFFaT0d3ZURVdkR4Z1VBWUI4TllHUDBMQ0pB?=
 =?utf-8?B?enU0bXc0UVY1MkROTU1mOUlReVlMdVZyZzYxcE5SV2lxN3lxTE0rQkdVME5i?=
 =?utf-8?B?V1JCUnhjeEMrVGFRWTdrTENtZWNWaEc5d0hYR0NSclJtdlZXR1JqK0Y1TzRP?=
 =?utf-8?B?eTNXV3pmWUtMZEFFWEp1K2ViUmVuUVNydGFkMmxEdW9JUGFJOCsxeTVVVWg1?=
 =?utf-8?B?d3huV0E0cWJTV3lQVEVMZTQ3aHhNSi8vL0l0NWpKa1k4d0t2UjVUemxWU0gz?=
 =?utf-8?B?eVpQOUN1Ky9XYjBGaHhOK0YzeENUdU50ejNZS2s5RERRd2VzZ2Ezd3BHU1Jy?=
 =?utf-8?B?cHgzeTZyM0VST3BIOGNKTDBYTUFYcEZHVjZXeXhpSGdsK0s3TVBxODY1dlg1?=
 =?utf-8?B?L2ZwZzZ5WXExb2tMa2w0Nmh6Mk1SSUpBRFZSaXFkY2FmcjlucVBBcXo4WDNy?=
 =?utf-8?B?aWZ0WUFXMEhMN2JSL1ZCUzZKZ3p5L0F1eG9XdFF0YlQxMWR3TS8vdmk5bzB5?=
 =?utf-8?B?Mmp5dUplZ3dtWnU1ZVVkSGIzVExuanhyczFaVnhHUzMrK2RkS2NjUnJsbkdZ?=
 =?utf-8?B?ZUdKc0xCSlkrbnRDbUNTVDIxQjlaZ2hJc1ZSNGxlb0xWay81cllYN3MvYkhU?=
 =?utf-8?B?aXErdWVJUkdLQ0hyUno2c1NLUU84ZUcvc0swZU8ycVBDUXJRV2svNzhlSWpr?=
 =?utf-8?B?VlhjenNDTTJxU1VnOUk2dHAwQmhLSWw0RGZ0bUxYRXFCNitmdjVKOXc4OU02?=
 =?utf-8?B?MkM0bWxsTURwNFhJSGRhbkxyemFKQVoweCtaT0xDRGRpQ1U2Q1c4NUNEL3hD?=
 =?utf-8?B?elY0SXVYUHdwU1lqdGZOT3FMK2xRdk1mdlV3R1Z3Qk9obXQwSjlad05MY3V5?=
 =?utf-8?B?bVJBSDVZdVY0N1k3VTZ2ci9KcGZwRTU4eVRGelBYWW1Ecm1nVU1BUmlVcGtm?=
 =?utf-8?B?aXgzWWFmbGs2eStvTEhzSHRxUjExdXM4YUFrWlU1bnFOZlFvN1lmZU5TNVlI?=
 =?utf-8?B?TExVRmdyMGVMdE52TmYxdkI1anBGaDdQeTNWTkVMaTRpZGF6TmVlL3M0WG41?=
 =?utf-8?B?ZU5UOFR2ajJmbHNiU0R2NHRPVXM0VkI5bnpGOVlEMFlSRmV6NlhHNUlCMklv?=
 =?utf-8?B?MkZHc015WnRJclpXdXNnQnVYL3lzM0NWUXA5QmpqeGJrcTVXaFJ2Q25NcHhW?=
 =?utf-8?B?UHhzQXJOM1NYdVYza05DSXVFc21iUnRGVFlBMFBOTlBaVE5qZTVhWnJTOXlj?=
 =?utf-8?Q?XfiJVgCDTUj6YHVfiheBodt+pwNRXWOLlrTu357?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 247fcc43-3c7d-4b46-808f-08d947ba86ca
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2021 18:01:10.2345
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e4U4rePb8IaP6FyABakCX4kMPmlYkW2jBrcHm7ngVqM74toQI+++a4JBaw6+HCHx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5191
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jul 02, 2021 at 08:30:24PM +0800, ice_yangxiao@163.com wrote:
> From: Xiao Yang <yangx.jy@fujitsu.com>
> 
> Signed-off-by: Xiao Yang <yangx.jy@fujitsu.com>
> Reviewed-by: Håkon Bugge <haakon.bugge@oracle.com>
> Reviewed-by: Bob Pearson <rpearsonhpe@gmail.com>
> ---
>  drivers/infiniband/sw/rxe/rxe_mr.c | 1 -
>  1 file changed, 1 deletion(-)

Applied to for-next, thanks

Jason
