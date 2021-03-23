Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61150345413
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Mar 2021 01:46:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231160AbhCWAp6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 22 Mar 2021 20:45:58 -0400
Received: from mail-bn8nam12on2056.outbound.protection.outlook.com ([40.107.237.56]:51169
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231165AbhCWApp (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 22 Mar 2021 20:45:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AaKGWTqfMYP+cKJ1C/FDT2v1b47g+AqHM1vCUpe1bU/RgdZ0/Wpy7l8UAm7Y6dY5P+r6rewT1zYl+ABs3I6hH67xCR9anEVD2o5ZeO0vF3wpwnoXIiilg+zBUhUbRyri75arUrWxmD8HxvlsH+eAk82HD7TPjlUMBd945xQ2S7wP016U7kYxtsie1Dbn0Z/+gYV/OJJo11tq+tZek7jo3XD5ofgW6B4xvcUOCyQgJ3+5WCZsVp3qdMKd2hLjZVOwNZFYi2cLReGlOAgUtvEwSzOkUi729y18BSkLJav4MpiYaVwxXbmxZkodON3FNEjLFs3Ykr4BahWPav9o/BoMoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dKp7BCgn1lM1YuezOM7GHY9AVkjouM6EO3MgaLoioAI=;
 b=YXxbg9IQWCgkUJbtzhlT9LKUhEsnDla1GqIQ7UojnAlaPE5tehUByCJKUD4Pr+ZmGecFoHBvBUiDJjDZoORi669za8XSTD3Ap8ylbFe1Wy0KcemTbTJxFRb7t7bkEcyHjXAlI6+Z3c4pgbE6rTMi3sV/8ySJ9vqBXeCt+OJrUhigZmcrMJmUMLcMjIf+uKuxeCj+sN5zim2P384CgQ/ob5mrqGkvHlTrOVRlSsxQDTLxLElAnxk233rcKwSb0sJrMXquSYiiPI0krbcpQSXnMYm1xY9TZD2eUShYnWLQ+QcwC38VxkcDG8Y/u8Tukdqnp9Lp1PsN97TUGH+/JOAV1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dKp7BCgn1lM1YuezOM7GHY9AVkjouM6EO3MgaLoioAI=;
 b=a5kvx0yy6r/SlK+GuZrhxRz0TdVefJCOwWCI7Y7md/xiT7MybyyALnDQve7m8RuZ5U1GCrlz4LqZb4XW7XMD46R3gMoPdjQ8Np0r1+5MBbvyVRpJilNIP6v6tUVLtWtEjG9wKeqvWsMsfIpujVQeLKNiYqsfGjWNYhLwlXQ/9cTZl5gFLuT0zXTB2Zk0bKuN5jjQd1eAH7/fZZHR0HBKSDkCOzJKoRRWvQ0RcWgBSjV1HPlPQ+JDLg7Bqdik4WPmXtj+PExk1k6qC0krKFur989fk5V/gjt7SwibBy8aNIvAh7ghtcIAt6DHY6KBapihZFd1Omixasfhy3nsCGYZLQ==
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR1201MB0203.namprd12.prod.outlook.com (2603:10b6:4:56::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Tue, 23 Mar
 2021 00:45:43 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3955.027; Tue, 23 Mar 2021
 00:45:43 +0000
Date:   Mon, 22 Mar 2021 21:45:40 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>
Cc:     oulijun@huawei.com, huwei87@hisilicon.com, liweihang@huawei.com,
        dledford@redhat.com, dt@kernel.org, linux-rdma@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        rdunlap@infradead.org
Subject: Re: [PATCH] IB/hns: Fix a spelling
Message-ID: <20210323004540.GE247894@nvidia.com>
References: <20210322022751.4137205-1-unixbhaskar@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210322022751.4137205-1-unixbhaskar@gmail.com>
X-Originating-IP: [206.223.160.26]
X-ClientProxiedBy: YTXPR0101CA0055.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::32) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by YTXPR0101CA0055.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.24 via Frontend Transport; Tue, 23 Mar 2021 00:45:42 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lOVAy-001HYT-HQ; Mon, 22 Mar 2021 21:45:40 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 642d0cac-9c87-43ce-c339-08d8ed94fcf0
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0203:
X-Microsoft-Antispam-PRVS: <DM5PR1201MB02033A14B6FD0140FDF777F6C2649@DM5PR1201MB0203.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Dnw8iJnIJVXru6ZEI3EGn6fCuff8TL4tjUvoN0SnYR76cPBHwdhEwVIkI9h90ih0U0kZaVqXoqRx2YU4ctutbG8jpLjgtMLxozZ8M2arxVuej6CKVY5Gscgl3Yjn7iGJoZ9KLsph0xbODiS8h65xyy3RielNzhRYdLUTQy3NwHWXBOvTmshgGXUpdc+3tStTRIEnXzZUMrv8e1NwGWqBASYfwWxhAD5p9pF3a6SSs/6ryNxzeBJlAGC8tnj0bbtv2FRtLApyx67qB120ImEzFmMjd99WI2ISYvzyBedZklRIC/1WK7FQXz020dREqVDt21RAbwKw1CS3IoiF/KjqT/f4AtjNw0zk+zNwDUnfTRV7Zyd6tsNpUsGC8q7I/okXBKAXPegVFMfGYtfcerdbwd5ryL3kQVVvkVmhxI5nAf5nnAPQGQIWk4p6YQ1vm/o9Ky5OUGE/E+b1MoHhhgkuFD/TX/jCvu0CbPwL8SqD9hkO7yczIchgc6LA1xzmKa0JSIKr7aty6yhThf9uCrAzxiKpjruLbq3EBoHOBZw5pWF0X+Sl8PX4cdu1q4NpT5GYhI31tj22+q+C4V4xE4Ijsot9gUd7qyIrCQmiuST26vF8aaD9dzAVB0iZfwjrgWTRmeRmrfPZEStadIz3h8H5uRiIxGLQJdbZCwxgUVhIUxahKxAGGaURa3jHqChxpAIF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(136003)(366004)(39860400002)(396003)(36756003)(4744005)(33656002)(38100700001)(83380400001)(6916009)(1076003)(478600001)(7416002)(316002)(2616005)(4326008)(2906002)(26005)(186003)(426003)(9746002)(66556008)(66476007)(8936002)(66946007)(5660300002)(9786002)(8676002)(86362001)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?e9IZHBo5saLeNvON+SgwQUdxPNpaMREC/Dceq6zStQDneQy12DniiIKvu9vp?=
 =?us-ascii?Q?y5GHg0kPDsArKLX96jxGnsRGACDdoeq1Lo6xrSPCFKRr8jXUxGYNZhqUVo+s?=
 =?us-ascii?Q?ZTngn7adf+5s6I/MTOKfQpaMBwv+v49FiuFv2AIY6v3WOyRaHYagyRPZEXr6?=
 =?us-ascii?Q?vv7AqJpnQQe3GNew2Ejj2ktbeypzHOxms9MQ5bGzCUJd4OH0MDPbskI90jM2?=
 =?us-ascii?Q?kl0uIxtt/D2M6iiKVYoLt/8W6O/c1g2khotqhMI9KHuLkwuIE2o2T660sKV1?=
 =?us-ascii?Q?PWDx842aPUyt4u6bTuACz+W67Q5iKvi/MX1dyvOK4yc8GNuVcbO0Xp1DPe0R?=
 =?us-ascii?Q?yxvKL+wBuC444RwMKjCL7dczOINYBRTBFAjvuNk3mRKTXaUAyxLCpaQ1XGDL?=
 =?us-ascii?Q?+M4q69P/4Q63ONxEa8EHPwrzJakd3CqWBSP0Tv3LwNIGXPbM0LLLTH4uvaVR?=
 =?us-ascii?Q?rOWNIDX5r0jNNqCzS+8vTmWGYTT5k2iEyMiAkgx/0EZfSHR3Lhnjk3fk7dta?=
 =?us-ascii?Q?RJmd1MfBCCFsSiLJfCvi0W4p7Q/VUq/G7k/Lc147l6RGWZa5hfoXLJVQCN17?=
 =?us-ascii?Q?q06+nQqBqnzgXf5CWubuU7hrqlWr0Ck82KI0/YG7Nkqbhptx0vw2/8TnmGiz?=
 =?us-ascii?Q?MYqtMgsFSYowcV+jx6QiBfv9LvQOsAj1dRhUCGVxUIFeo0rGpOyE+LImd/iv?=
 =?us-ascii?Q?zXhAySOcLnsMO+ATw7QMc+flBPw5LJ974o6AuOoCOB24Nwvo1SeYz14mvYwt?=
 =?us-ascii?Q?6TMKda5z7oEtgKcu9pwGmm9xQBr6aOGEjNT5aay0W4lPfWu3vFQQP+8gd0Lq?=
 =?us-ascii?Q?RA4bGbJhwEGQ7vc671lBDVnxn5ccqhAU/fE/eRf4EqCvP3FF9HGDjfol0EHZ?=
 =?us-ascii?Q?GQ4qsZnedSE0kte4YQTj0UUY1FWOYrTzue1yqriDjPuDvOSU5iGrAeHqqUHU?=
 =?us-ascii?Q?Jaw0o0k05L3j6vwW2AboOpk4D//+Rt6i9fzQ6NdNyEArYUjFT8FpNVTwfEVA?=
 =?us-ascii?Q?gsNzjvI7oKyRe6ujsgX5DSN0VN85MLR874qkDCWoRYflqWjQwpINhM1YWisX?=
 =?us-ascii?Q?iEHMcvNFpGXjzEwO+pZ+LdkX42+U1khSplpp52l0cvejrQtokkIuekahr9tU?=
 =?us-ascii?Q?/4jX6RswYrK37rPfIGTLASGNNjYWvI7/8S7ud3UHID/KEYm0JFlgRAENVgTe?=
 =?us-ascii?Q?zlFoc0SIht7feXXov8NWaFEQLgly86FIjhFadqVlwBAAKwjcXkAUOCa1p3ws?=
 =?us-ascii?Q?kKB/QCb7xIIkL4AWB4J2hat/XY+cya3FuEHOHSLzHOX9pmDEk5uQJUm6jmDs?=
 =?us-ascii?Q?Y2xp4h2Nu5pMrf5shsdq58DT?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 642d0cac-9c87-43ce-c339-08d8ed94fcf0
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2021 00:45:43.1852
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zlYD7752eWfXJYji5DxMK7G2knGvMy+Jt1/GAhQZPCBMtRAUuyCKXtM/ICRxYbdV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0203
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Mar 22, 2021 at 07:57:51AM +0530, Bhaskar Chowdhury wrote:
> s/wubsytem/subsystem/
> 
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
> Acked-by: Weihang Li <liweihang@huawei.com>
> ---
>  .../devicetree/bindings/infiniband/hisilicon-hns-roce.txt       | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to for-next, with the comma fixed

Thanks,
Jason
