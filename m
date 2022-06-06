Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B346353E622
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Jun 2022 19:06:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241000AbiFFPsJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 Jun 2022 11:48:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241059AbiFFPsG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 6 Jun 2022 11:48:06 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2054.outbound.protection.outlook.com [40.107.237.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5CE3B0431
        for <linux-rdma@vger.kernel.org>; Mon,  6 Jun 2022 08:47:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IG0amjSIRDuybmvpD3mWXF07MDZIDp6YkEKS8QACRQhdt0WkERX4dyZhHHv4maHosHQCQi8JoaovudbrPTiM0wxFHvqOipxgnR517TuWP1ZfbUqUBHYNsZV1CzKpoooSLhge8K7f+Q5kzkIvukOOOq9v36yY1D1nTxPIfq95aBGNKvxY3owBxEjT9DyjNMFDNtyImTpmkKdh2xqyEqoa33WoQD4xG5beV9jvk7FgxMSMUVWAECmuq1/PnYeewnKww7Ndg0EzOXh9iLlwZxLWzAx1ympWWPl59KZX7QmFRM8ek8lVyRJSEbzm2FSEOrFF81paR/BrEh46AwQV3b0eyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=potcWicVUssdRiQTXV53EvdaxUGuSvgAvaNlEEWXe+8=;
 b=gOhGvJtWu/HEsN7ruZKdYz13v3o9rwdMntz/4sdWcWIOZcK4yYtdyL94zILU3HVXce4J+v1qc+SAodUAvaFphl03q1UZKwJZ8ENsQfx/yv1SDtGrUjcgkjlClL+AechlPgMxqK2ZbXx9j+UxK+/tHmBY9Ik9HmL6iWPj5AUJwYIM90q1p/9HCVl8X9I6lSIYQVHZIXsnrO+GG0XFiRJNS2qu5DxA40xXcTcBskZBYfqwEl0HFQyRxWI61UJOWvhDUMZd7r7JG4Te9CkF3DbGVcN6cI7XTsLFQEH0SM3HdrWMBD4sqowMI+VD+LQ5lF9RFSlbT1JGBxJcBsMRIO4zsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=potcWicVUssdRiQTXV53EvdaxUGuSvgAvaNlEEWXe+8=;
 b=E1CQENmI8DZIhuyXW/5Ds8jlFIfT9M+RlwoMKx6Jwpharmx7Rh3uXvpgnwtgkhK8L5ZsW7pryV3ur5Ne6QCIav9ZVYHrkcAgYEbJEX4Eevzq34Yj93+Ouvzof/qLaLry43+gTde/GlG0ZOaY5XUvgfJXCdPH26e/pgi5m6BKmApI9gmupJulPm9hXAwXRhAT0Xv33EYWhSTV5Q5SkK2Sm/S/f4YXdiURvkTjqKYs2N6qaCIhOk0cLxID639/VlDw/MGEfkbLVVChWVWjeuaTxAWnKf7ImUAJr7KhjykM7RGiByJqUH3G2eQyYLVaMxPSfNUuI9n/U6vcKNEbDfiq4A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by MWHPR12MB1728.namprd12.prod.outlook.com (2603:10b6:300:112::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.15; Mon, 6 Jun
 2022 15:47:56 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::2484:51da:d56f:f1a5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::2484:51da:d56f:f1a5%9]) with mapi id 15.20.5314.019; Mon, 6 Jun 2022
 15:47:56 +0000
Date:   Mon, 6 Jun 2022 12:47:54 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Cheng Xu <chengyou@linux.alibaba.com>
Cc:     dledford@redhat.com, leon@kernel.org, linux-rdma@vger.kernel.org,
        KaiShen@linux.alibaba.com, tonylu@linux.alibaba.com,
        BMT@zurich.ibm.com
Subject: Re: [PATCH for-next v9 00/11] Elastic RDMA Adapter (ERDMA) driver
Message-ID: <20220606154754.GA645238@nvidia.com>
References: <20220523075528.35017-1-chengyou@linux.alibaba.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220523075528.35017-1-chengyou@linux.alibaba.com>
X-ClientProxiedBy: BLAPR03CA0103.namprd03.prod.outlook.com
 (2603:10b6:208:32a::18) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3151fc0a-5135-43bd-f20d-08da47d3eca7
X-MS-TrafficTypeDiagnostic: MWHPR12MB1728:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB1728EA5ED0CFAD69FB6B108AC2A29@MWHPR12MB1728.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7xEaOl4+GEt6GgxNSFr+is5NXdwP0EAjwkRMHxEb9quZXFHfKo3ShiYpJfnbgWx3a6pvq/rHweD3oZDi+g2yR+VvHBr+FfOztNSjBcpPx6C2h6UQH8n+fcFkRCwIx2twq7jsYRHg0nDtalRxBIhi0d2NIxELbga8FtWilF21H6roelCgbRn9VVDgBUCMu2h3+4297LQmSNKL5M8Zc6qwdHOEvZA2yVE555VZuR2ew0Fij7g46YBlvEPn1E3uxlgGFC3wP+R5aec84GPZCMoiLABLr6aLrIzF0v3wLG+VQ3JyKCBs4GQ/DlPSyoy+NojyTOg/Avokbd1WCsdG8ZUvX0SN9G1E6o3d1WLY+6fjwbq+9jkzOz9cXLf/K3rQALylYmSxH0O9Xuffjuzgox0G71R9AqK0PTDiMc9AzliYFzOoKYJESrwTGujLoRCwrmBzbzCpgtmHCKQatiRQuhT4nBiwxPqlmtvRUYJnydQzNDQTHGUmXLzWiJLSSYEzI349BDesV++viCV1OWCL4TNMSbKvBOBEIHRVCWBkrk09KU5slTxn4VNS4V+rKoaFPva5z3xFvmSzqIpfEavgewrLwkKQ69ecnVoUDHEOvw6Gqnk/omGpf/l0aFFZwGHsTJdp/4AELFMnLgYlyz89BiyK5DEEy2bnAE5TlCHH8gYdEWMLajISaNReNllu3Cifm/ah
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(26005)(86362001)(508600001)(6486002)(2906002)(38100700002)(33656002)(316002)(1076003)(186003)(2616005)(6512007)(6916009)(6506007)(5660300002)(36756003)(4326008)(8676002)(8936002)(66556008)(66946007)(66476007)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jRYgJC6r86K+LQcbamiIimLFLdy1jgYQPN/uBZPNn9h8o2GuO2zpxP1b2KNp?=
 =?us-ascii?Q?snEJ2YTzWGxi/bv2VraBNQkrFYiOyzaAaqXMp71/QLMXjYoiE7QA53ihMWM+?=
 =?us-ascii?Q?6tjdbmw3kXRkjuQihsRTPgDzKSHHf1m9c2npCpxu/JL3xF+BlFAcFfkVVh9+?=
 =?us-ascii?Q?KoO+H41qhr0DLhYZ6x4XcXG1hSpPYqd931UgTRdlKHPeyUOo5YAeV0TsTsDw?=
 =?us-ascii?Q?mxFB3aRQKO/ERL16Ko66QSdZG9pOG4BOmt9bDdxzNv77jTIbta+9J7opLwYt?=
 =?us-ascii?Q?0mA/MH3ZCJ6tKHjZcUN/ePLhtltLVoQs+Yt75pyvvpUQd2YLqJM5KUNxDzJX?=
 =?us-ascii?Q?43xgHYIo2iFbotZTWIyWuEdh4fBX82YegJxcQj9A196sfaLar3nKNxhyd+Eh?=
 =?us-ascii?Q?6WOuN7WURAX+FBPFQjuLffLe4aM+Lcv1MCa0vu/1WM2RM+II/LtTON+lvLoz?=
 =?us-ascii?Q?liYB3Ps89j9aJwPp7yse8sPPYCK87b/nCfdFtZu68O+Yvjo2fPl7074BOebQ?=
 =?us-ascii?Q?uIxxeeptDI1SwVEKb8nTC0dZ8wVE3ab3PKoUHB7XK3IPH0CpzQTmF4flFuHn?=
 =?us-ascii?Q?wIc2ceeNZ4+HdtHDPxMPLtCJ4jeB9nru7cneIjpcpPjF7OUe2Y7u2FCGAhqu?=
 =?us-ascii?Q?bg/M+eGpVs9ezWuAAo2uGSY5fO+tGRi2Hs5SsauLPw6X/gYKSwxGkSO2YOxx?=
 =?us-ascii?Q?H3IMgwozh+uGSA9iJhMQ8+FpOyHPwTrtfVqT4FbcHcExyvDpMDo5raFz9pEY?=
 =?us-ascii?Q?BbKBRgSe9uUzDQBtYHITxMfhtUJE2CzkcNvE4lHYwaG8bJZM1KTocEwX2/iH?=
 =?us-ascii?Q?5XV/jMeeoZACETaVLtRs2uqymXAsWKUR+K2aEHX0Pv9IsL01kO98H7tZB1ZO?=
 =?us-ascii?Q?H6X8DbqgVwCrLNBoXA3Vc0uYcSfUvq7/mE5hrYuuNfPkJxJ2SmCEA8K4GZqM?=
 =?us-ascii?Q?d2Y84BJK7/njUNtR5FViWl1/YdxaTy0xkuN7WkPY1aHu+BS81fm6ZXRVx+ca?=
 =?us-ascii?Q?g7veWGDc1K7bPbCiiKx769GjQ7BoONPBJLQ3wtCM+L/tYp/1HiD1BAppQWfC?=
 =?us-ascii?Q?TpGc1KFrLDyX4X6pG1MfjwOGvvub5GLHv9lO5/ICNO7vuruhyspAHlcAHcul?=
 =?us-ascii?Q?xpml9PklNQVo2Dy8gySLH/m/hCyeCKWoXWaA4YJms0rq2lUZCpP2CdkJbUW/?=
 =?us-ascii?Q?4nUQ6yyykvTuBLFXFjHRGfomxXLHkzl7L7WkgNR6uUew4cVwYGvweVQkR8Jo?=
 =?us-ascii?Q?wNozA8BYX6v25C9ENnEQ9Qg6JmhN/QPKOK508Mu1godIPlsvnA9lMKX3vONS?=
 =?us-ascii?Q?Uac/rFfKEzlUUaAaQVFJ+Iu785cr4+cfJl5+evFDdsXDPpNLT4CFaxIN2WrI?=
 =?us-ascii?Q?/GjFSnF+HH0ifkUWXqy1ebSYmbn2PWopMMyxGQyVuKV/7/033WwhrwosBDUn?=
 =?us-ascii?Q?tT+VvdOph7lE+q0mt8+Kh6HPqLiFfQxYYEBuFOeVjR6WI/PLJycFJBkOFkXi?=
 =?us-ascii?Q?DnH9fctZcYtPF0woVV2vBg8tsWlsrNsng3yG/OBRm8I8R0IWqBy6MiFNaauT?=
 =?us-ascii?Q?uhVJ7NbEEA10F3/vRicgjQXqKQdV+6A7j/XOAjC5GW5nIGP6mCPpxSOjL612?=
 =?us-ascii?Q?fmBEJkxX2BISgbSBtuS4Nae3Hb2QHEC2JtgdswR0RdGB/3bgihvTkZJhIXl8?=
 =?us-ascii?Q?Mpa7bPJKFv7AqmY/waq+MN8nfqUlQNC5XXah34ShQx9VDN/dNrJnMkphEwTE?=
 =?us-ascii?Q?5EIFdGSbOw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3151fc0a-5135-43bd-f20d-08da47d3eca7
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2022 15:47:56.3571
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lSc0bt6XKmSddbCzzAboo7cT1OgFGuwAJ9BqhJdpx+Fz5CcWe/OSbdXUS4ynoAWf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1728
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, May 23, 2022 at 03:55:17PM +0800, Cheng Xu wrote:
> Hello all,
> 
> This v9 patch set introduces the Elastic RDMA Adapter (ERDMA) driver,
> which released in Apsara Conference 2021 by Alibaba. The PR of ERDMA
> userspace provider has already been created [1].
> 
> ERDMA enables large-scale RDMA acceleration capability in Alibaba ECS
> environment, initially offered in g7re instance. It can improve the
> efficiency of large-scale distributed computing and communication
> significantly and expand dynamically with the cluster scale of Alibaba
> Cloud.
> 
> ERDMA is a RDMA networking adapter based on the Alibaba MOC hardware. It
> works in the VPC network environment (overlay network), and uses iWarp
> transport protocol. ERDMA supports reliable connection (RC). ERDMA also
> supports both kernel space and user space verbs. Now we have already
> supported HPC/AI applications with libfabric, NoF and some other internal
> verbs libraries, such as xrdma, epsl, etc,.
> 
> For the ECS instance with RDMA enabled, our MOC hardware generates two
> kinds of PCI devices: one for ERDMA, and one for the original net device
> (virtio-net). They are separated PCI devices.
> 
> Fixed issues or changes in v9:
> - Refactor the implementation of netdev bind flow in erdma.
> - Remove the modification of iw_query_port due to the refactor.

I've put this into linux-next - usually you will get a bunch of static
checker reports so lets imagine a v10 re-post after that concludes.

Thanks,
Jason
