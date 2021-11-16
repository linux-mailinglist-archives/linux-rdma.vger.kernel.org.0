Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DAFD4538F8
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Nov 2021 18:57:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239135AbhKPSAJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 16 Nov 2021 13:00:09 -0500
Received: from mail-bn7nam10on2068.outbound.protection.outlook.com ([40.107.92.68]:44704
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239158AbhKPSAI (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 16 Nov 2021 13:00:08 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a+nGdJ7S8mRVFN+hliReMSMxzes3wTkxDnJvHJcKbP4sNxybXe7A882gmohpPHnTt+q1ujrbm3B2vNbb5dNmqHfNlAiXWUETL0ZWxLcCB5VA6mDb4u5nXYiXDvdfnneOy82JKVnKVWdpzQjf43WJOPY3aq7j//fn5vV1a1VJNtCXMOiDg9vJfFG3Id+JCNhSYGHNrSANiWRjK/0CnRXBXZURPx6wE2gQllumxB/X1vqaSFrcO2kkovX6OYXnT+zb3HqTIDaz2nUjHP+KQJ/SP8hH7+qGqvdnNqcxJ/FQZtia9V9tDoCqhyKneLQ4OEguG8UMtdQnuof5p+nU7zxn+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l/5tV84y0w2g5AcT10aeGEmh+zBUtA5UlPc2nqKtGIA=;
 b=Mpurgods314vmJ1pEArjDcfzWSn8a1gk6Bbp6EhvOHJy44wG9hT2p7f5dXptZGiUYEAcXvWLBpT5G/27PEB8pXL6vUF+UVcQ+0vVhkmUmAINRmGRvZO2F+wqynjTGqYAtXQ+cxtiCRkIp8n9gwy3whv8guw8QWBr+nvaeI51oZG3x4ipM+/64DtFpsqNnhs1POAFciovKReqLXTV8CZgkGRdQ+/mGlcLkfzkcjjzoCYU9zvgMMBL0lZg7WEFfVWnL1HQMyUINs3UyjSpsrJFeTrFMqbL+8vJx3a7k4LFNqGXyujr21yhZ2sx0WHwplQZDuYuw4YDmasAvbxghGkNpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l/5tV84y0w2g5AcT10aeGEmh+zBUtA5UlPc2nqKtGIA=;
 b=J62HrWdaq41l8yGLtPMCZ/8sc+jmG5LiqD3sOlmEWxsCMMjNsWiaOc69UiAAReKIiBJ/MeOrNYvFOfOkMJRAN2O0nFTW6Vykuc8xDjn/XdR2gUGl8vNNQMHwh6++Z+Fi/a1i6oOc9VGuDedMlkHH6ICg18pyfVZK94tM5bkezKooMYRZWE/Y0Fk+ooEv39PAJl+vMbbMcS8st4dBVY/GoH6aMOFL3nV5GTBGMMj9q/LF/WCBBpSWky0a+lLzQ2d/fPmmCuN5mg4m+kMbzKki9mv/1w+MFM1Zn+G8rzSAQHcLNUWsy6PHJGubcRGlwvPX1DZVuB8fsSVT3Dz+symQcw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5271.namprd12.prod.outlook.com (2603:10b6:208:315::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Tue, 16 Nov
 2021 17:57:10 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::5897:83b2:a704:7909]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::5897:83b2:a704:7909%7]) with mapi id 15.20.4690.027; Tue, 16 Nov 2021
 17:57:10 +0000
Date:   Tue, 16 Nov 2021 13:57:08 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     cgel.zte@gmail.com
Cc:     selvin.xavier@broadcom.com, dledford@redhat.com,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Changcheng Deng <deng.changcheng@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH] RDMA/bnxt_re: remove unneeded variable
Message-ID: <20211116175708.GB2661511@nvidia.com>
References: <20211109113227.132596-1-deng.changcheng@zte.com.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211109113227.132596-1-deng.changcheng@zte.com.cn>
X-ClientProxiedBy: YTXPR0101CA0042.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::19) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (206.223.160.26) by YTXPR0101CA0042.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19 via Frontend Transport; Tue, 16 Nov 2021 17:57:10 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mn2hg-00BAOo-Kl; Tue, 16 Nov 2021 13:57:08 -0400
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7924bfd4-b53e-47cc-06ae-08d9a92a8319
X-MS-TrafficTypeDiagnostic: BL1PR12MB5271:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5271FB49F11428F21244C450C2999@BL1PR12MB5271.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2201;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3ovjwLYW07DfXvIB0ceV0Li6TTpk+dELpbwVtNvjrKCon6Eq4hNnJFxYp31EJmSckuNFfygRFJVt73kiabDvHkFrkWLd3vQ4Be9wQ+FwZluxbxZcizeH/CMDYa+B/glU3S5EWFg3fLkua8WEZpKIwABg+XTbZIYLFivXqsO2NYaZNNU1D+ls/NiEMS9q57zTF9xjqAtzBOx/0chqTQTEXL3fHfp02OiC8HuwTERiSSoJK6c9ljZPrk0NWlDfcDeKxRYYHAWK40y5Rgjym23k35wZ2pP8/64cHUrWBbZNkZIbdEOLtMMWE5LKo5GuHGZmXei0v95uM2/vnRzls870XjL02pw1PcIEBRJwdEBMUcp5yqURXfwVJw734XdIP+AXH1P6vqPCmRlkP/Sg+Ki6QPNLHHxCE8wQNNchX9YTmAJ9sdbS/8dbxxpl7R8EVBN7j5EtRnNoJEKmFMvuyR5qj+JQC7tZtvFjSlPOnuX8VUk5eblHfZQDiev12cYmjyhnWvrGAS6oCNljYvlj8FurqhFIOMwFZjmlDQHhGOEzIEng/0NU5NsQnLz3uZHZN60ShVgvr1QZh/mn+u5Uc12zhCvHyxylFFS4aB1tmspAMx+TtLSS7bv6VLPIOJJNwcHTbwB0tJ3INAL7SQyjL5S6Cg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(83380400001)(66476007)(426003)(186003)(66946007)(26005)(6916009)(9746002)(66556008)(1076003)(316002)(9786002)(2616005)(86362001)(4326008)(508600001)(8936002)(4744005)(54906003)(2906002)(8676002)(36756003)(5660300002)(33656002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vlki4B5seTyVRiqBiESZLNZ7H2Zddcl9q4pi5sJl14mJut+urmUCRGF3XIg7?=
 =?us-ascii?Q?C0IdVPhcfj8EFh6zuqmI/ZBWwubpNSFYt9zvhAZGN9EY9Y9xtaMqGpLgydH0?=
 =?us-ascii?Q?rmL8JvUcNVOwAKIbGsU+xgnrahY4GRpv7uS30RJtPn58DGJKuMuuTtB/2I3F?=
 =?us-ascii?Q?O8KCDGi1FfZeXXLSeC4MgE2P97n3dBefv6n+ypk6fLh9pmlYS1G5rEt4jcfz?=
 =?us-ascii?Q?Z7O6wA7rEDFrwkN32UXEMiCX00dGBZ6kwpIP4X2SUL50PqUjC+xuUrGsN2m3?=
 =?us-ascii?Q?j0xuyz2HE4mERVSdvF8HM6hVUnXkG2I+H8EchqpeWBc7ZQQNl0TiUn0Lcc9B?=
 =?us-ascii?Q?gf77dopehJxbZD8vcCWeMUUiLVL5cIikp6/x1ldX1EhFPHb8hGkC4cOr2hw5?=
 =?us-ascii?Q?dTwrslkPnz6PRDpH4SqSZhAz/xSJ67nTQioNs8y0oLVcynjLjwBC4vXMBydN?=
 =?us-ascii?Q?eDwSLitarraRi6JgESeuJx/ynu4wObl5oIDqvFONQvUlQi/txa3YFutKuKk8?=
 =?us-ascii?Q?RgCTVwGHS6hXgfzgRaOn9OeUTaHuFVJd5n28/Eg//bikBJcPnA+WpI+kqXSu?=
 =?us-ascii?Q?b8B6Gj0/9hld9RDYO96DVZOAXpGmHcrR2RCHKUWajjVz2CdnnWNO7XIVnfUV?=
 =?us-ascii?Q?VBoXJE4nKJHk4uv6nTOIQOgALAbfM/xWqENLAp0GkB4XUycj/LPZ9nA+Is2H?=
 =?us-ascii?Q?lbGAfTQNq4jyQMShiNsXLQEMqsTDEOaHUr2JsbFP8OSMyW86yFOsOZ2UObhD?=
 =?us-ascii?Q?oA0ALrpGGtuqw6MXMrrIZceo6kC/o/stf57QEm+a2l8vxHYOvPUHWiFneO8O?=
 =?us-ascii?Q?MxZmf3d+JBxpabg4mcdl2PjwjAa8+xTlTKQk/Yduk1XCIrPFIbfj7o8OndYo?=
 =?us-ascii?Q?zPn8x/Etf51NIAPkf97mfh/tOYlNw9prTrsKia0XjX/GzCtqgjKHpDFgmcaY?=
 =?us-ascii?Q?NOZfMlpxnKmur3iR36918r7zRvmu7VSx1Yv1ESZzA2kN+dQIoWJHEjk+cwWa?=
 =?us-ascii?Q?N2KhUx8XQQYMuLO8dbbibv3iu4k76nXGgVoxS4ecGgkqdFLwb3c41VWKvsDA?=
 =?us-ascii?Q?jse0Sjt/ZYdHOXJIX4Z/vA8L+WxPKfchihoO911RMJAWDJBM7CFifv4VN0/u?=
 =?us-ascii?Q?RoPdGyF0KAuITEQ5y7xsZva8DILftM9a/o8QjDtRTkRTuNTBIpAzRHlSXzk8?=
 =?us-ascii?Q?QQhwj/WNew2eoVczUqLs+d4uvq+ZvtCAuVq37m8BkVi3P2BRAnSsZ2ASgvZW?=
 =?us-ascii?Q?pF9s4jx9eZz+kyEwSZ92Pehreij9w3mQwvLTX/9j+LbxS5x1McI/Jz/z//bG?=
 =?us-ascii?Q?QzlGDeeDCKRjAegO1HAYJNUctX4DjICRZjFjBgUmG6ywhXLh66JD2AD53Y39?=
 =?us-ascii?Q?Q3rZ1rbuongr5akSsYJPmthcdxuzvvNto2g16FEKjTWhdzANe/3Qhyeenx7/?=
 =?us-ascii?Q?m2mIufsoXAmGG6rsUzsepcebpS/AinEqNjsaOzH10Rkv4mKXmWBdw9y50h6S?=
 =?us-ascii?Q?pIxnziT9S8Ne37tEmMxo1TNUDsl8MICRG/L8fr4i3QYpzEdE9aL+g5z+bxCR?=
 =?us-ascii?Q?t+5u2nNEAFRiLGpRQKo=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7924bfd4-b53e-47cc-06ae-08d9a92a8319
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2021 17:57:10.5460
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D8IICynZN9KocPzcM+hJiVlcZ8RPRpYIwkKg3SU8yl6V2jGvFqdKV3UiaDT+08AG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5271
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Nov 09, 2021 at 11:32:27AM +0000, cgel.zte@gmail.com wrote:
> From: Changcheng Deng <deng.changcheng@zte.com.cn>
> 
> Fix the following coccicheck review:
> ./drivers/infiniband/hw/bnxt_re/main.c: 896: 5-7: Unneeded variable
> 
> Remove unneeded variable used to store return value.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Changcheng Deng <deng.changcheng@zte.com.cn>
> Reviewed-By: Devesh Sharma <devesh.s.sharma@oracle.com>
> ---
>  drivers/infiniband/hw/bnxt_re/main.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Applied to for-next, thanks

Jason
