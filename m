Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E01158448F
	for <lists+linux-rdma@lfdr.de>; Thu, 28 Jul 2022 19:02:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232266AbiG1RCW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 28 Jul 2022 13:02:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbiG1RCV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 28 Jul 2022 13:02:21 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2041.outbound.protection.outlook.com [40.107.96.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B517A71BE0;
        Thu, 28 Jul 2022 10:02:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L3/ue2FcTQ+rdFvAPFvrzAXEw3XBEaXAMrhVAcryfWMoM0HMxVmvq3nyikpxlkwBB2Q6T30N8TwY0Rw6WxAShx6X0RPVf58qExRdw2rXtju8OInSNpVMSqutOYykl48dnTlaU5PsxBY0rXZG/C+tpkAHgLX9e2t5f01ir8IyrKRhjxx4lUBavA/fyXswiMOB22A+KN9Y09ZGEXP6iWC+6g0hRKQCriHjLeTwre2uLVAlU1GpzFyTau8B3OK1hdCt0amuWGXO2rErHTXUZLraJt6fxHInxhepKGMlzXg1oH2VGPADJgPZXVZg4EDnZThaEoErUTXXDJp5kjMIISfv7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JqHIyRfio6ojXlQaIbZJyR48JzeEZ6L9RidxQBsdA5w=;
 b=S9J+58aX03R49mgGw0nNHQ+i+XN9njXJ0ZZ2L/5mZHJccRey7UKDPwUBLkx2GzuoJpophehH/gAFfy06NgAykovxV8NNc2t6wCyIzZtzp87QZesmqyRR5ckfceDLDY9b9I110e8zSlhdzjGrxwwx7tQNZgum608jytirETJwjM0E5trC3CZifKvv28NAoY4fZPxH4qxr7bEDWbwLWl4X4ggeKM1IfKUD8yYMrkFa/HmJozH6+/f93gwUCzW+/dqyAJRGn8adXS+IaQ2AW1G2sSjMXUHOz/YtfoqvxOTCxaOFxoux70AxCxI8fJxkBs9jYR8IzrXwe6Em3ZwhDtGMQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JqHIyRfio6ojXlQaIbZJyR48JzeEZ6L9RidxQBsdA5w=;
 b=RfdgfDl9q4PA75nnxBygf+UBlijaSXMt2T7HZ2kwGCpfQtxCrZsVKpoRbkWiq9O/GHQnhd8tMR0vCR990ncV+n+Xpe3E9Xms+f+PdmB2B5NVdFJtdXQ55v0F16N4LBvsoeQvtsBGpf9uf3xpreMquK0UaTeDKp8xsCImblMEgM+Ul66qT8uuJV8mIFYz54k+1P94JkxYCwjmogUEVQoec1+9AniFOCCtJlAGALP48xpfsXmLDrWkfZCkygPBqsFITOUL4z7YAIKyNf+huAKO4hlSy2tRWuQ7xCLK/vPcbOYlOKYJDQ+y2PgVXgVl8hnINFLLU0aE6d2RwUTAmTffgQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by SA0PR12MB4368.namprd12.prod.outlook.com (2603:10b6:806:9f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.6; Thu, 28 Jul
 2022 17:02:19 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::4cce:310f:93:5d58]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::4cce:310f:93:5d58%8]) with mapi id 15.20.5482.006; Thu, 28 Jul 2022
 17:02:19 +0000
Date:   Thu, 28 Jul 2022 12:50:50 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     wangjianli <wangjianli@cdjrlc.com>
Cc:     dennis.dalessandro@cornelisnetworks.com, leon@kernel.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hw/qib: fix repeated words in comments
Message-ID: <YuKwWXC6YUqvzgwd@nvidia.com>
References: <20220724074407.18552-1-wangjianli@cdjrlc.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220724074407.18552-1-wangjianli@cdjrlc.com>
X-ClientProxiedBy: MN2PR04CA0032.namprd04.prod.outlook.com
 (2603:10b6:208:d4::45) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a76e02fe-2b54-43fe-f1f5-08da70baee4e
X-MS-TrafficTypeDiagnostic: SA0PR12MB4368:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TYQRmx5sKC0te79uvTdWjFwjthQJvVlcou9ct9KhYpIIEnxuivCckzsoZ8uazm5ugiJqd1/NclpV/6bcB6pPcpMoKPgLxGgTDMOD2htkJMCLSAnddwt25BIbnqpMEI39Lmf57CaHjAZdR7hmOJ7WtcHy7PBHu/4pbNpNbDQyMeiY9Xrz2dwiuOid9pAYOp/sI+a53rptMvTMcuz6yc7IyDDiUWzTwvINcqEOSPnP+aiJ0PhW3xxMaigbybgdAC+Lc6mfr7qO+x+3UKay9Ub4KUlSywNr4yIP+hnNPgpKZF9v2nHVwIQXEfafhj/0ai4287y/3hCwoP+HD5A8ujaeCMGb3lbFZRY3lEScReR9RAl8giSX0x+ODCMOcpwiVQ//w0CXOpDZvfMkzzyGvEHaVGSaRRI3wg3EppOl3WLhOvMIsKsK3GRT4gqJECF2KGRf2nOgreYET6ysb5AKTDBVbHuiPfmCU0acHYdHoVrfbOVl8Nys9d5kqR3y21VbCyr8bxibDcqaMln85ySM9DqWu0uiejRZuuqXcCkUAr81wlh3md/Lybzz8/Gl4MFUsDOm7h2Y4r94FeOdpPZ+5S5v+RYFa1UQkkYVoi193BA6OOlhC2bRLOXiQ7oP1hGmw+qN1SCW5HUJAjQsGPw0NFijrA4E+qgKrV/3E42EKkq3VTRSn22klxMObPtHGALMNhlB5TbnLYK/n0Kw6RXpWk9ESusjtrCqJaVpwIKUarJFv1ncOofuMqcJgB5Mr1MtGt5t
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(39860400002)(346002)(136003)(366004)(396003)(316002)(6486002)(86362001)(558084003)(36756003)(6512007)(478600001)(6666004)(6506007)(6916009)(2616005)(38100700002)(26005)(8676002)(4326008)(186003)(8936002)(2906002)(5660300002)(66476007)(66556008)(66946007)(41300700001)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hR7xDt8sC9xMcMBKdEf5GfQEyTXV9Ickb9e8J/NoUhh41FnUOVdYeToN0HA4?=
 =?us-ascii?Q?scrYo/JVf7xWtE9DJTnovW8UTYD9xcs08cDAFXTM+9HnWZOtceEXPiltM7+n?=
 =?us-ascii?Q?GqDJJLwzg2QMz5wdqZurpEUONkh0FqYfraXnnGF10CyYP/dYjG1OkrghF4wv?=
 =?us-ascii?Q?mnCUZwr1+HxO/uXN/84RsLYHIi6pmfKU8eJriMS7rqOm+HW8dfuNjnDH5Vun?=
 =?us-ascii?Q?GpX/wL2dznTGLFZZL5MFLdQMECMlCrQ9fJ2pH3ZY0lo5ay2/s6Do+OTiyOZu?=
 =?us-ascii?Q?ms1w56iuknNOdF1q5I2LGqpdz5Bq7OEtwP5kO3TB9+m45Iso2pBcPq5/MMIL?=
 =?us-ascii?Q?in2z6cUsuZEoHMpxHSzaOyY0xlBbvyWVTV8fT3l/aJCzUn+E9DmDeFZ8DtV7?=
 =?us-ascii?Q?KXWJIDSNFC2/UIR4caQDnVr9kXmidRLnnmm1aDwZ6Rfh5BnNSjYAFYE01g/0?=
 =?us-ascii?Q?j1pH+D2aus9RO+lfCVbe2PBEwKQY9JNF0S3L82tD1jnOZCntcAx5GOXPzJcl?=
 =?us-ascii?Q?I35TL1/CdKc6wHLpq5hEx17DIQ7WaDcuyU5pHqWuOogYjzPzYV/WQ4MFc2Ap?=
 =?us-ascii?Q?3JW3N5mr4jlpW48rCtIBsObI0vNmxzHkyqQzgqx32Cy9fYRiAePk1/N5dnwr?=
 =?us-ascii?Q?PSSuMT6lD2paMd6L62tEE9gKt2Ed7vqJn166S26DWTAgofOfLY5B5II/FqN+?=
 =?us-ascii?Q?9zOXBzct9jGVhXPaERDc7Y0Cfj8ldnbi1A8LeEKxLghlDLDvEBvsrYsD/iyb?=
 =?us-ascii?Q?iBmE7D+n6LxC8wmBQ4GqufGKuD8cE740Uenxgl8OPhXvASmLyyFYkrKLvZO4?=
 =?us-ascii?Q?0nVjSDVmApDoPsxKswa7VdLmMkZRHoy3lCqUFzWaz5hLzA/t5dA6Yot23K0W?=
 =?us-ascii?Q?I7qR7H9Y/PfCljy+uOJtODX1gWq7WUvRaHahwwgHqUgKmECNGY6hjSGn7HDg?=
 =?us-ascii?Q?cjYXDw6BE86FS4n5N3p680KfCt0yyFDguuCY1yQSPG2Vm55axQWhOsudo7JE?=
 =?us-ascii?Q?JaTXZKRcAmKJP1ssCoo7ZR2ZFDzO8wWwwqDgLipcxgJpQqNFjr26K/aMuuv0?=
 =?us-ascii?Q?lVV1w7iUvqE0cBEddsESRk8/gbRS+e7WsRa5+K1UGSjphqD5m8fcklnDxRw7?=
 =?us-ascii?Q?bAmidaooA/71oZ6dRNF8OW+ycqBv2FY2bW+goJaIvg8IQ5UXiBfwhDiAhRbL?=
 =?us-ascii?Q?+YXK16WC1QrgyPh9RPQFdqky1EvPcZ92j9RW6r2aOD26BHCeGWvh3VRi+At0?=
 =?us-ascii?Q?BzpZatmh+KD6zT+DA30MGXtTYLByixO2mDOUiJi5PuhCI9EOr/Zb1HBVZ9sy?=
 =?us-ascii?Q?V5qU5IlTCs1MnXQd5IQot2Ge6IeCjVZj0DraAOY0dsV6IrWHseaAjD4T2Rww?=
 =?us-ascii?Q?1uUthW6835N5DuQtrOVy3TNGqzm+/B5U5CNxCagwfWe1HQ9S7KB4xw0Iasv7?=
 =?us-ascii?Q?x2n92GsphfW0vaXV+jNQRAvawNoPhGd3WoMJoJcdptCWZxAZl2leBZNo/U0U?=
 =?us-ascii?Q?5Rgv1AG8/LYLudoTX1WOgiJfriUtU33qT/RETk97mEEAaGQLowj2r+uRQr/d?=
 =?us-ascii?Q?3WnXcnhQDdsxiYhWe7knv8l7pxX7YRtg7VkCcMhn?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a76e02fe-2b54-43fe-f1f5-08da70baee4e
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2022 17:02:19.2444
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GkGPqdXuNlOW5OZmuG7WhOr5rtBc0fBrCY+qOErQhXF42gYhvo2LnbKtkK0e6ON9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4368
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Jul 24, 2022 at 03:44:07PM +0800, wangjianli wrote:
> Delete the redundant word 'in'.
> 
> Signed-off-by: wangjianli <wangjianli@cdjrlc.com>
> ---
>  drivers/infiniband/hw/qib/qib_iba7220.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to for-next, thanks

Jason
