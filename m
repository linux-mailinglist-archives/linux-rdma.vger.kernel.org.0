Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFBB362FBC3
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Nov 2022 18:35:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242574AbiKRRfI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 18 Nov 2022 12:35:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235353AbiKRRej (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 18 Nov 2022 12:34:39 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2053.outbound.protection.outlook.com [40.107.223.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A76FBB7CD;
        Fri, 18 Nov 2022 09:33:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aDlOtwJnKg3Izz6Qhx42lE6mmaL2n8dwOt3STxeXWDKFR5QmuZggIvtbLPpWgYZC0cFxbP0Qm6K3t/MSK9D7tnx4HcUxNM7Q0zWal7ohbRw+EfTSZw22CDipNQpJpuv5gNkO5YW+NTu7pq00iXJ9EePMvqyge6W4yeQdGzGv8oeaadni7oKIDW0N4GBl1ScQBgTChJFl1GLGmeFJfVUp9NC76a58kosXoH654Zg/aUjeamqb3g3+cqTb6wexP+qQldntCBkb2yu9yEDHdqQ/Ek4yD5ZjV4U8RnmkVczCjOffRuNbLpnSM8K6UTItGh3jk2k13wuqk5G7gt9ikVgetQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=40k9e3cRmkpnM7bI6MPW3LSz74E6aRwDgMWlbdAaWbI=;
 b=mU55FeRf7251NnibnmTiLM3iGkBfPquLWg6eKsabji9o7D7eal2ClAcx4hL4UIz9WvLoS9NuhsEV/Apuv7ZdqN2idCZBKBAtgTbb+xOLFM+k6NAGYJdg0MLVGSBERS0MiXqPYLST9JKR+kO23WdMzqGEsNxxlWlB0esquHgXlzbCvzRNDYdT/ZB9VfQ3hkJU8gRZZqXxBLQEsOeFOBk6M9O/jzU4OtsOnzzkgT0oRs/Xfxx97PXDJNTdxM+kAQQ7VrRhB9kvLIbqFfj8Av8JFO9y3HegTAKCo3e61WIcMeIExddpGZjqUkk5Nku04MJlNLdA+WTgt+JC+7kqI7d3wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=40k9e3cRmkpnM7bI6MPW3LSz74E6aRwDgMWlbdAaWbI=;
 b=Z0TTAdbjNDs/P8me/Onnt/RK1H6cbBdpLfaxToy+jYehdbOgyN2rBwpZt8FaO0clf5pKuqVlYERYWFPVz33Nmya9KfJKu+6h8m9iIdSeQJ1Xycy0vas7xkhsdTpxNJ/eBNRhJHDJC+CXz43ZwseaKbkl207jMV54umRjMZsA2LG2zWNpeuBlcsVz9AYly6n3CtpE/SWwtqhL6QSOWKObMDsu6AiOnttsjNqNULqqCCL9IUmNueKt7/q5vh3gwQsNvU0T8RDRMgns+Ka87E7GYSCVoVi8UjJEPKXYc5T3a4YTqHJpgf0x0uiZyfCvwoEaReQnRxb0Nx4moKrnwGbIpw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SJ0PR12MB5503.namprd12.prod.outlook.com (2603:10b6:a03:37f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.9; Fri, 18 Nov
 2022 17:33:31 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%7]) with mapi id 15.20.5813.017; Fri, 18 Nov 2022
 17:33:31 +0000
Date:   Fri, 18 Nov 2022 13:33:30 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Li Zhijian <lizhijian@fujitsu.com>
Cc:     Zhu Yanjun <zyjzyj2000@gmail.com>,
        Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [for-next PATCH 4/5] RDMA/rxe: refactor iova_to_vaddr
Message-ID: <Y3fB6jhde7hpIm5/@nvidia.com>
References: <1668141030-2-1-git-send-email-lizhijian@fujitsu.com>
 <1668141030-2-5-git-send-email-lizhijian@fujitsu.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1668141030-2-5-git-send-email-lizhijian@fujitsu.com>
X-ClientProxiedBy: MN2PR05CA0064.namprd05.prod.outlook.com
 (2603:10b6:208:236::33) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SJ0PR12MB5503:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d56512b-e72e-41d0-7fa0-08dac98b02e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yqCuwaTv2ThykvoCVeMZ1FHFEiCWyckjd2vyCCRYCPypczUL0E0ro7zlY7BIxnrwye2oGudSvA9fv8AO2p8luZOoXHMtJxQBHqGy+RqFJMt2MLkfdJRrFAmJIpR4wx+AJE0wKHal0UIAC10iBXwmmUf9GLyvXNLN9yJl3mmfi2vUDM+mmlFuZLIJBupAjIcOGbSrLQTEr7Ti3WxqpFJizKA6XD5pqnLGDInynmBnOxFgovgUyPduThhvsyA0VvndkBzS2UL+2+ajrF59WtzrzDxkQup4cBN1Cd8fjq8r4dyks93KAs41WcyqiWLG+P0bO1c6CmG6o+SpgCK6Woixcm5RkSEj2lzn0xv4qlUwp2FbkLLy6DPlcylpn8U1QQTj+3iqguuIhBCnzERZPbl7YKqI8KFhwGlvw5rw7aFdEAARoqktxN9dfC82D1C8hwbi51QAp6PWdWMKcNp/A1NtKPRNP0l4qryfqmwNZVHvdAxVP6twZ7PK18rekhu4WEvJHfgHlJsStBEthmeq/+/l17LHaKBrAtStToAGJO+cvndjcV2SCcR3vP1GZhj/pWp83IQtnDfg5pYXdSfCmnvw5HV9ibmjso4H8K1cycWODYRs1XAlltm92YrzXF0EB9+LHagzFQryRFYM0zgntV7awg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(136003)(39860400002)(366004)(346002)(451199015)(2906002)(26005)(54906003)(6916009)(316002)(8936002)(186003)(2616005)(36756003)(4744005)(66556008)(8676002)(66946007)(4326008)(66476007)(6512007)(5660300002)(41300700001)(38100700002)(86362001)(6486002)(478600001)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WlkXujKbSqqMOl/FceC/dzz/5U2U93hzp0rzCw7w2TP06pEMHbQrZFmlyqme?=
 =?us-ascii?Q?CjNY049zQJRdOs//o7Ofkbnf6gqgKYUSV6DcBZh2fQTRS4pGMvq2czvq5TLu?=
 =?us-ascii?Q?Wmmh3+t0tbiU5sWp1XoTrqTeAJUPJcbwF9M4sdvZ6BVWDB39e8rgSsAIey05?=
 =?us-ascii?Q?oKBFpGurcgPcp69SvX/VCXm9PUTyFA+nYxB/DhFTE17Z+5yxZGmlPU5yMjLv?=
 =?us-ascii?Q?ISnvzcvuA17DtWDpbPp+uxSfBCoExzm9NpCfoNoLUgoGnB35Qemue2iEUjTg?=
 =?us-ascii?Q?POGb1oAT40e4Byy59VW4eBWzaNPp2LTj8wI22cUa6b5av74Ah7+e+x007LMR?=
 =?us-ascii?Q?fvAVfHP9VHeXQ8j/hvYtMceLnW57tLEyGpKtrR1gVr7OwlOgtRWxW5/wA2dL?=
 =?us-ascii?Q?zssknMEYchTD4qRm/aed5d+MDAlecnbwxh/rZ3z0X9go7irEYlnrf4BACxnU?=
 =?us-ascii?Q?qR3vswKsqHChsCGYKcD8xqcl8E5nBQws89jLqjy9j9sfAcscgY58pdEm9+7R?=
 =?us-ascii?Q?X4qS7DsQsQP8u22uAfRClXhTCLtBVqR/9Gy97nbXL/zJDCvUccft7wQeS593?=
 =?us-ascii?Q?hPUhMHg8tSMo48SUI2SQyM8jhBuuJxet7gd50Enny1OPs13cCp+yn1s/MGAx?=
 =?us-ascii?Q?IWXf5osQ/BnAxlWT7qFPhlO1er3ycC1SryjhOIyL0URgNKXJNWn+qB3eGGy1?=
 =?us-ascii?Q?xf3kzPPiOCWiTmo16k9oaizotZg1ZTWvSmxpX4sJUup6J6AEc8bcUi6fdaV7?=
 =?us-ascii?Q?lhsBHWZVTkrjCHSwrje0LhuzQl8HA7FW9gNHWOkn1LOM5axb9g3miaUqs6Bu?=
 =?us-ascii?Q?ksg6egRENw5hh1eoPNkL1QbVp5LIj3ZBajqmGIEW3CTrOx0MsiOeBHs/MbXu?=
 =?us-ascii?Q?wbfRfDk4ASNN6ndLVVnHfQf6BnpcA1OEp4St4swjrqu8dIzZPkiWwNN1eZ/+?=
 =?us-ascii?Q?zjnrtPQVG0yrs89HoLtcBIUbLuzW91vWrTx8n5553OF9IQIcF0WLNOqtHgDH?=
 =?us-ascii?Q?Sn3lwR9mK0I5MvPtHyHGyRaELSrPVGAKF8tDI+Ke0gf2YLRtY/WZUjq9KAO3?=
 =?us-ascii?Q?FQJfXQ2AeHFRBibFBAdQ1RM0pnABKoTkH53qRYFJPH1A0hcuGrY7pa8+VxkE?=
 =?us-ascii?Q?2OQVUCAHPIO14OtndkfAarSeNhkJD/Ehkh0Bmdal6rtvK+a+YpiXgk/ZePsF?=
 =?us-ascii?Q?X+Z19F52FaY403iQaQOhsce5hDYlG6rx0NO1T1szj4b2EoKLuMMcgbnJjqUq?=
 =?us-ascii?Q?9WwQ6V58NKL0Yh4/wbpZl6iR/00bZ8cvUr1PROhisb4XKzaSRzVjAo39JWPd?=
 =?us-ascii?Q?OLPtHAXVyir0IuW0cThTZqnd5GivPHIVuFSdtxLuatZ8op9mmM4x5rTQFDaT?=
 =?us-ascii?Q?Wkvk59FzPc3B3tdMAXejncQ6wwx+MduaCrcxnYXkOpAPUr01vjIvqAsl8XEf?=
 =?us-ascii?Q?4v0M2FUsnBz+lkeMFk5y60sRqSnE+MvxyKvu6d8IY7/Jsct/MsCLxUVmZolJ?=
 =?us-ascii?Q?qLw0hkNoJkW9TmqpFZxhTCT3CihSzp2bjqxJTIhVqo28Eq8hu6noh35d3woH?=
 =?us-ascii?Q?TJOS9zbFx8JIHIJGZYU=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d56512b-e72e-41d0-7fa0-08dac98b02e6
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2022 17:33:31.4987
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7zZ0m7oj1X45KLlfHJHRgUNfSlCnypb+UNM3ushOakY9fqMe9NH0Dan6XHzqf5Xr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5503
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Nov 11, 2022 at 04:30:29AM +0000, Li Zhijian wrote:

> diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
> index acab785ba7e2..6080a4b32f09 100644
> --- a/drivers/infiniband/sw/rxe/rxe_verbs.h
> +++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
> @@ -280,7 +280,10 @@ enum rxe_mr_lookup_type {
>  #define RXE_BUF_PER_MAP		(PAGE_SIZE / sizeof(struct rxe_phys_buf))
>  
>  struct rxe_phys_buf {
> -	u64      addr;
> +	union {
> +		u64 addr; /* IB_MR_TYPE_MEM_REG */
> +		struct page *page; /* IB_MR_TYPE_USER */
> +	};

Everything rxe handles is a struct page, even the kernel
registrations.

Jason
