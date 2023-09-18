Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B41E7A498C
	for <lists+linux-rdma@lfdr.de>; Mon, 18 Sep 2023 14:25:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233326AbjIRMZT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 18 Sep 2023 08:25:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241983AbjIRMZJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 18 Sep 2023 08:25:09 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 068EB9F
        for <linux-rdma@vger.kernel.org>; Mon, 18 Sep 2023 05:25:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BtD09OKeQsubnkUxsm9nWQU1BTc0o+9W18gtq0Q7/FkNxVxQa96bRf+7xgsV1AdkCPRYOCf98dnDOwfTL38ZVapxDrOwukC1/DtVQbZiuYlKIBk+Em9vxO8qv6UHFAuHHXqplPtpZ6ilPLKpE2/yzQv3JFu9jMFps86vkh1LRb+sidl0Wj2W9j/z/8DofsgoEBZXIQvBqaLK4sbi8SW4EjA+ZXnDC5kmJq5Lie9ya3APDxpVh+7cWTrrVfzqvz98aZKPV7G9ZinfMk6Of8KtSiwpucTtA2SqABufCT4yYH5OJCiCCTYm3PbodVsnhMDxelXFdaHrB90QCNj9vACZew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+uCeS+s+UDrVB7F3QbkLoJrmSLXzF+FUsADB2gJON3Y=;
 b=V8A+Xy6JVNrEr3sHCGdMBr8U0Hhah81z1CXZZ3k8pKOoPg0/5jw7GuAMzh5w3Q1b5fRtjDhjOwET9ubpUadfduGlBXEVQesa2eQ92M/Ph67DzA5vYKZ8Kv61gzhTXLy1SnWHSs+xv4f4EWqNGVMLASICaOdtsYaRiaN7iplaScFG9o6tqjCDRz3Df2DJ47p1NsQfy9qCKC0MJPHw2DXOss4XnBYH8XtTovwJH6sfg7AvzhvpDo9BBkoCw/+ChD1aHhrFVp4qnczxw9l6Xbxsxi9tkkz+6ONmYYPOyFRNHdpu/LlKM0/zX01APxa1VU6kZT8IvC0c4Gvqb+xCvDuBNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+uCeS+s+UDrVB7F3QbkLoJrmSLXzF+FUsADB2gJON3Y=;
 b=DRbsjyl1vrv8a8agGWXSbOjhosp2MTG7YhNJjqG2V2POr5Gi5S7W/TDqEd2PpTPwqf4/xogLP4JhQMjfzAViQFA4ZQM/SvP6yq6VfYIHWmQwBoNTWmMgAfy0E8+dZpbw2zDIdDbNbENzYdIcTEOwTe2Q5HAnNwdJdhlzyVQ1U9cywsWvOqHxrnTOjr0Mk/zbuOS25YXEvf/014BPLkl4JdSPyMwKbYjwwWUcS6KUSKFlZMqCPTe30Civ4VL6BBlcLsUoOjBJp+5e8IZvm8A2byKfmZJm0+4wsRfzMpTZJria5hmcqozs3nCazPMcha0HA/w58J/1ElsZCmOZwbnWcA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DS7PR12MB5743.namprd12.prod.outlook.com (2603:10b6:8:72::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20; Mon, 18 Sep
 2023 12:25:01 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::faf:4cd0:ae27:1073]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::faf:4cd0:ae27:1073%6]) with mapi id 15.20.6792.026; Mon, 18 Sep 2023
 12:25:01 +0000
Date:   Mon, 18 Sep 2023 09:25:00 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>,
        "lizhijian@futitsu.com" <lizhijian@futitsu.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Zhu Yanjun <yanjun.zhu@linux.dev>
Subject: Re: [PATCH for-next] RDMA/rxe: Complete removing newlines from debug
 macros
Message-ID: <20230918122500.GC13733@nvidia.com>
References: <20230914163959.85586-1-rpearsonhpe@gmail.com>
 <370d9b26-51b6-f34e-b833-1cae2eb3136e@linux.dev>
 <74f6a2a3-b556-c716-62d0-58fd0d493fab@fujitsu.com>
 <52ce3314-0e25-8e25-44c0-1c6702da9372@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52ce3314-0e25-8e25-44c0-1c6702da9372@gmail.com>
X-ClientProxiedBy: MN2PR19CA0024.namprd19.prod.outlook.com
 (2603:10b6:208:178::37) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DS7PR12MB5743:EE_
X-MS-Office365-Filtering-Correlation-Id: 239b4bdc-67cb-4df8-9968-08dbb84247cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fYK0T6mid7wgKX/fa63KvithOFut3QjBcGt66rbhHb52nYTiEDRczAj+9AqMW3oPhGSea9f54I48wCus/M4QvQ/vDFUY4FLK5U6f0V7sccU9VuIZxTf6RDVxfEKfO+ps+qCFjmUK8Yp/9Q3bZWII+yFT/P/eGoGBvS2AxeSocF5tP2I/jXK9MAwHrHODyfjSxTuLx3frsJwAMxgxa+9406ufRjs7Pll/CvW2QMGEBcpiHKf+O7tbkZgNIqLHz1PHJKHHyRD9S8lxffmgOr89Ziz18vkG4C5qWTUdycaWxoxfKgJ3mlckF+QCH//WCNIE+abz3TN6NT9P2nRtnEkid05frjcsfJ9I2F8BTTxlqv+eAq9/TMq8rbPvE53Oqr5/7N7QcQGjRytwiCHelAco5venMdx9apxJy4XCxtp+kAJC1nunrPTIkTObE4ub7Klu4T3PrrMAtqqPtEnEBaIqG/j+YjRq7ZebAUS0yMgYlx7TWXx2kdBZDlJhE1+05Qltze6psT8HFv6RFxEqUMs9BpyBm9CzexRrkiLmoCKiD5QHOeV/hwJqY3DiHGGy6bAo
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(346002)(396003)(366004)(39860400002)(1800799009)(451199024)(186009)(33656002)(316002)(86362001)(2906002)(4744005)(36756003)(26005)(1076003)(2616005)(5660300002)(6512007)(53546011)(4326008)(8676002)(8936002)(6506007)(6486002)(478600001)(38100700002)(54906003)(66476007)(66946007)(66556008)(6916009)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5MDVmwOOEN4c5k1L1sEysTtF+ra04l7T3pxZX64YUuTDuZEh6GNTQWj/kqmm?=
 =?us-ascii?Q?PxcIMovgPEya0++1v6L6s4VrFabIpUi2C8uD4vRmcRHgRki13fFzGE05cWcK?=
 =?us-ascii?Q?13kCDSEQC8DvgYIDWTS5u0egZqB0woKmtpHO0VDObGYsuZBohTLFxLcZr3Mx?=
 =?us-ascii?Q?5+qlNmdwocLuKWesTs1xFwxJPEGRmercRnudDCaCDsnrmxjbaXKKJPwfJhoe?=
 =?us-ascii?Q?HoPko3dlE29cdodKIzC4+Kr0t3iRSh3Zc4e7jn1c2V+Q5hTN4bYvpS1Byfqt?=
 =?us-ascii?Q?PrGjphWLuEU+KPX8Gul4rkSjb0wXRf76ldiaPn2rHcgz95mYBg+StjYD5q8l?=
 =?us-ascii?Q?TNuaFtm8iikqiPJXjLvGQzItvP0DaKF25vwH+tlcYV5g2htBzF3UoNRZ38fm?=
 =?us-ascii?Q?lflfCzd/A7mjxBMfPfb9r4Aj/Rf6GK207w5aN7FYj3bOZ22gGzF3YkbO3NhP?=
 =?us-ascii?Q?8KYn8D86SZbdX+xy72asX7fgwua61Ll/VA6nwf512blvgkh2GHC0enU+n1nj?=
 =?us-ascii?Q?JkZh4Ldhx+XpUSTxUJsSGH3byO6aIJZyGR8R0fifYerLyov+E0Faoroe4qre?=
 =?us-ascii?Q?JKkYAsrhZR/wt12lgmHasXzVEIKyiwgMWSmIQ2LZcRXu4Tv6i8aN7HPgkDZh?=
 =?us-ascii?Q?3Z8kZAANJfMt3C9v6G8yMVOVKTxtFv/jiBNYBt3qEYqUOrGg52EKBtftU3l2?=
 =?us-ascii?Q?iNFYI1xaNWiUlvavYTpktjMs9WXi0YtLT6CT1nVtwNYKMOl4ZHmhuZMVBedr?=
 =?us-ascii?Q?rGBBqz+tATjqEycKZJQ8nxBEUv5UGxBnKifJbcK0CIwNvoSe0v3W/UDYN2d2?=
 =?us-ascii?Q?gPh86/0B/QJAJF2bab8tEeF1K6CR3W921x9MGgE/X9QLLT1U1OH+l3UTAl8G?=
 =?us-ascii?Q?lQkVRb6S0SDxqvk4xvXZM/ZTnp/1WM3akrwuQVoDOguklZ1cfc430M0YHr9Y?=
 =?us-ascii?Q?WkSAeyIEc+N5NpeKUUD+LNQdxloLjoSTf0hwNM4On0Dyt6Mr97J321RaQvuf?=
 =?us-ascii?Q?gTRHrTs/d3HQnIMtkP2eKWykJo7s3z/M71w6uRdvIJ92jxL8AeUavc5gOkH5?=
 =?us-ascii?Q?3e9IDk3NRqDUhcgeF/nMYmOb3a8V3fWQ/Mu3QGjiRWN/nQbGyNByspO3Z3gm?=
 =?us-ascii?Q?7HmvxhxN+hCo5hpaw3NJELvLES1x8uBMGcaslCx2DsrCob3tH0orbVaw/1is?=
 =?us-ascii?Q?36Ci6B5KHH7fWgELFYcjLlz5adryuEYCyUVfm1JD3nFspqqekQUom6yM1VXo?=
 =?us-ascii?Q?8ICbwoq2vAKz4MvK3nEv3Pfg7fBjxt5D6IDKPTphLFjU10J+7ABqIGayd3Ri?=
 =?us-ascii?Q?Rn08XFGZTDKDHrhQ7rd7tS/TVUVL6rpWvTnG5MDvwwu3VJ1mj1nWb2vItmdO?=
 =?us-ascii?Q?RldcDjqIlWJXoN0QjQwXKOUANwKm8TIe8vIbK1JZR28vgdcyEnu/2PZmDrD7?=
 =?us-ascii?Q?klPMhbe/SA+eaEPPJCd9PcQNgdN0YYcSOlj/vLcMVI16h+AuF6FxJw7ceKR/?=
 =?us-ascii?Q?AGrFNY+n033+3hZ1D07bPWR8extCrHs1DN2lm4w5BQQmvrVR8kmkYQmYlnn0?=
 =?us-ascii?Q?i3NQQbmcll7eHCyUmCM=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 239b4bdc-67cb-4df8-9968-08dbb84247cc
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2023 12:25:01.5968
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Epf3BQjGhNxz10sFmtnaV1erh4l4ZX3wvl8TdRyvRrt6h11YGG+nxdWHXM15PwTa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5743
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Sep 15, 2023 at 09:38:10AM -0500, Bob Pearson wrote:
> On 9/14/23 21:24, Zhijian Li (Fujitsu) wrote:
> > Bob,
> > 
> > Since i didn't get you original patch for some reasons, I reply here :).
> 
> My typing was very bad that day. I think Zhu fixed the rmda->rdma one.
> Hopefully you now have it.

The patch didn't get to patch works so you will have to send it again..

Jason
