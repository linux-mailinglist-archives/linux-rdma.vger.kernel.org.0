Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3492D60EE40
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Oct 2022 05:02:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234182AbiJ0DCE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 26 Oct 2022 23:02:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234075AbiJ0DCB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 26 Oct 2022 23:02:01 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2066.outbound.protection.outlook.com [40.107.223.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FF6D5EDCD
        for <linux-rdma@vger.kernel.org>; Wed, 26 Oct 2022 20:02:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i9B8SjFXHXiE3ntYNLAN+Ef66phEkxarJiQUQtgEuoEGurqR0xbeJFUtfy8QdN2q5lYiwqtBuxuO9WxzgweANy4iwtjJS+Dr3YeYpQ01KSCeSZ9ja6drSxV9yDcQFfaGX5w8gEm31gVBULA0BzdruS8zVveUhAc4hf5KxmI+ghv6L792pCeFCsjtSOXYM62HVKn4ruslsE+d+M/dl0clKhomsMSg4ftEj30BH7nUo02cyKaMt965x2C2uSxH7aPE9lRPT2Tnrtefo6VkPGEDpvMyjhBu/O9JKRazotDSBPC4C0DUWuAkK4/A77lkL2mFL9Bkvw+RipbRJfMJwaI/yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fKbrbjqUkdi71oKuBif5yIrYKCRoqdmyK15eTqI/Op4=;
 b=iIdxLn5DtG1YwI63MPYDyJ0Oo6oYkDCKbAfYQZW+oANs5P5c0o2DjJyrr3f93gblpvQYvio8mJHyBKEqwd7kjpguVj0EBf1xrsWRwbBrD/k59OgXlODjCLe1OFmb03k/4O9XjO5qbnlHqyt9iNqP4gtrKFESsVl7N88tGGlQZtPOnjhzbtkQp43DK9Xk/QYnY4nMS8OSrA60cl9aj1SsHs5baHcz5mkQV++OAlyeDx0QpOIFmmWsh5tidzcZXvkdPKuJarfxZq3Ns6A8nHGBCmT2bl8XoVJWiYwwwh+SYikqw6rNxPY23sE1oGtupaR57Vh8/+NBHGmhKAVuBmiiaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fKbrbjqUkdi71oKuBif5yIrYKCRoqdmyK15eTqI/Op4=;
 b=GQC0YKFyCahhhTfZEnWzP6uWvi9Bj7tVrqTDokNgpNyKZ/E7J63CF6nAlWfv6n0fq/anjGOyL5bmFQa1LGJKkDr0xg9ClKSLg1/nIKlO+u/dXB/+b+t6Hkbo2QnwPh6fb0m3f0HFmqhTdfMHxTUIuaGHRkbin6pLPzHlDfcAkvUM7DBdkHXSaZEOs9gyn/fIzMc1ULJsHncBw3+ox31D7TRMPqCsQL6dThVBP1irovHqRQTbGYi4gzem1Tx0KOQu5eeOhbpzA3Yg5RwwrJdt4V0sZJsGkCDU9Ke0vT2e+GkAhqN0IAvcYpPMBtIuBhm7uX/edeAZrDisjZHC3XQ7Wg==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by LV2PR12MB5895.namprd12.prod.outlook.com (2603:10b6:408:173::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Thu, 27 Oct
 2022 03:01:56 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::d756:c945:3194:629e]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::d756:c945:3194:629e%9]) with mapi id 15.20.5746.028; Thu, 27 Oct 2022
 03:01:56 +0000
From:   Parav Pandit <parav@nvidia.com>
To:     "dust.li@linux.alibaba.com" <dust.li@linux.alibaba.com>,
        Zhu Yanjun <yanjun.zhu@intel.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "yanjun.zhu@linux.dev" <yanjun.zhu@linux.dev>
Subject: RE: [PATCH 0/3] RDMA net namespace
Thread-Topic: [PATCH 0/3] RDMA net namespace
Thread-Index: AQHY5qHU4bwCU56Yj0mBzA3dKbf6464gylCAgADAs4CAAAgm4A==
Date:   Thu, 27 Oct 2022 03:01:56 +0000
Message-ID: <PH0PR12MB5481F98B1941FA63985D13E0DC339@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20221023220450.2287909-1-yanjun.zhu@intel.com>
 <20221026150113.GG56517@linux.alibaba.com>
 <20221027023055.GH56517@linux.alibaba.com>
In-Reply-To: <20221027023055.GH56517@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|LV2PR12MB5895:EE_
x-ms-office365-filtering-correlation-id: f5deb02f-72f3-4e6f-5acb-08dab7c79bcd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LPM+7oKiPe3E/Cv+awbnIKoSM8hhVA83vhtD2kL7/UiNrkjo3+gFF1tKUMYsXK8ow5dAh12GLfpcj6/b/Jsec9s87l8GHI2emCJzD/+nS1uARPEZYFdPvrzhJFWGiYvv637G+fmpbtpzEocU4z0PJp7bG2omOi+H0GbHyADdayQg7ecB5wvTdI2c0ZvHrYH4M//L+W0M50U42EmC8ey7zq9aBghCxLVzYZSljneq6ZETRlFGPUixn/2ojAhpaQxeyoOd4rFWKZNiP4cOU+GHz1bKzuOp52i0Y2MKMDlTfrDP1Btqpy1nmF0YddKGGt3WHDbbm/aDaUde2IoUJdymtO+x24Og8TuxIn4YlR/BNwS9uN7QP/nDnG+2qDhBlHY1rMilUmfT732/I/w8BcwBgSvGC13FyDezfJxh2HnBJWViq0C2y4PZuiBarSsn0i9TEx6O0mrW0mTksuE0EvpwtSuKawJ/Xy/dWSBc4dlT3YffZ0b7I9QSG6vYgdjbIcpHaAHCJQv4/FkJ2BT8JJtpmQvfE/StduKGsO0LzJXvlwfNNWilwd/HnSQLjZ5S3mFwT3nBRQWuV5tvPW5P/4RfR0wnrwy2r5ke7NKWBSHWJErEWIKuk0gkTrxVPowzz9SflKIb83ta5X6iJWXHKzxr7uwpi4lahIWYUa5eZrt9o0jKGbdZ2J4pqOjfdarlI5bs2ctAfCQdi8xbF5l5pRBcKYsZ+jekVlly9IIm7/pS26yEThUOGvoBSqnE6WZKR1JgQ1m7MV4XAM9wnP4POWZLpA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(136003)(396003)(366004)(376002)(451199015)(33656002)(8676002)(76116006)(66946007)(66556008)(66476007)(66446008)(64756008)(6506007)(7696005)(110136005)(316002)(38100700002)(8936002)(52536014)(26005)(41300700001)(122000001)(86362001)(55016003)(9686003)(2906002)(38070700005)(4744005)(5660300002)(186003)(71200400001)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?SAIU4OrN1h4anJQeWzjKuxWikIOZ9a2Wh8SUK1YyynIbKHh38prmyv6E9QUp?=
 =?us-ascii?Q?2Kszcmye8yJjHCORQWldSvnvMsJPlrjyTEw3nzHy5lIL0Dxq4xC803qGAgqa?=
 =?us-ascii?Q?dukBtLSGTLm/Cp3WB9agoEBclw4if6ijXt8beeGQ1XuVHlaiY4+RZkMKYdMA?=
 =?us-ascii?Q?BBxnkHgGxHbBSAPpWVPj30ULPEkNu+LEgobQVLAsNbxU2V5DgMOzoUpUOzPq?=
 =?us-ascii?Q?ImPBnqr1tK8NAc/BXwEgT81NztRgwaW3mQxeaUCx1ztalMkYvpugH+ExnvpF?=
 =?us-ascii?Q?D9NTAC+btdBlNiFmrqOG/NEGTURVQDbCLHOrMi/DycecIRF+F57ZuhSd+UdJ?=
 =?us-ascii?Q?qeBaF5EoWuh6X6mEBpzD9paitvXem9iDskXkcg0efhE+pqwVUVxwNU7q9dvI?=
 =?us-ascii?Q?lSeMlZqRbigcZN0UUxFOAOMgnWXFOX9zbQOUhr/c50CYryT0czZ5TJ0f+bC0?=
 =?us-ascii?Q?iGjZwzEMEXKmYUjGy7Vb0oaa+TbV+EyIuWba23klKUhpC0XYouhNWwyfRCL8?=
 =?us-ascii?Q?mLB58L44obcu/pVjZPVLokA6RGSuiUkPmt11g7U4ZJ5oX1rhK+rI7jKJv9KX?=
 =?us-ascii?Q?5yPcW4irXGOU7StfYALDJa28hasQWJyUQg+wU2f1lam/UL2sj5qncSx/tA5M?=
 =?us-ascii?Q?z9b7Sc2oDfpKKPFyzJA6tTEac50WkuIenBni5MAjdxvSql4Z26qWPNW0R5n5?=
 =?us-ascii?Q?Fm7003EsCl5BEluKwW5xwFIekbYesnmA9QJhdYCKnQwuY2RGxM6tLjAoN4u0?=
 =?us-ascii?Q?wJpNhTbQF5BYgMnXKSLqru7/fvxxm7ULO70JdbsGuP07v5mq+f/y0JkKzLvG?=
 =?us-ascii?Q?W2gIM3t32hU8O/+jCB/rVqtUGaKZKasnXXi1lGinXHkkvPy7EWP2Zxr+B9pS?=
 =?us-ascii?Q?Vaipm217r0aj/ThHGNECzOX0Enb/WcJMjK+T5fIF9EuDMMpzdvEeOhesplYs?=
 =?us-ascii?Q?s47BZFepWHGys7ZTReJ4JQ70uXmdofL6cOOQtg0Z1idTPuDYfQvrH+fNVKvR?=
 =?us-ascii?Q?DOC9fi+iA09W1TBD0fsb0ZNOYlfWuyCLCwlmSilYuzKzXk49zzOwM0zoli09?=
 =?us-ascii?Q?1EdYW0xJC4O32WceUYbBDFYJisa+rGPrw8a2JFK+j/KXRiiDoQKuqTRtcUuy?=
 =?us-ascii?Q?EW8RWIKiFfJX8biEokUYgkuaGw91uGNO5y1xHpiPkFEiBWGlifPbEfJmGE4b?=
 =?us-ascii?Q?X5C3Xc32dfjZ3t1bGjP7b1ZrCNmh+TWbtnU+4OMxyZCwhpbD+AvULxHw4/ZK?=
 =?us-ascii?Q?cHP8QrDd/pr4fuMoIO0I4bmfAAPF5uJtqj/wkamFlJNDB3YGC8PyTAW5k6V8?=
 =?us-ascii?Q?3NucehER8OtrdX1feifMrWP4ud7517i2JTaFVjlP+mdpgbvsZziZvWT+MZeG?=
 =?us-ascii?Q?ulXaUFY9X53mZjnhr60rXu9ZaDYBsn8ZlC5pqQNNssY9Zhd5pt0VSUW7FpRP?=
 =?us-ascii?Q?h2NPnbDuV9MDkWvepOiumju40dv/UccmQBeQCpt8HLC/BronJWDN/ZTUZs9j?=
 =?us-ascii?Q?pVgmzC2VDZ3rUiROWGblMZIZKxDn6D5etJJIaBTpoCmeS+4CAJ7b2+7vktV2?=
 =?us-ascii?Q?gyxtA/kpn9cD3zhXbUg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5deb02f-72f3-4e6f-5acb-08dab7c79bcd
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2022 03:01:56.6179
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cgGAMgmW33BZuRaqO8SN3Jv9eH4moL94jkeOVl+8J8C1Jq+twFZk/2f7pxM1vkQxLSrso6Oxy2UYm44WU0xgjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5895
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> From: Dust Li <dust.li@linux.alibaba.com>
> Sent: Wednesday, October 26, 2022 10:31 PM


> 2. else we are in
> exclusive mode. When the corresponding netdevice of the RoCE
>    or iWarp device is moved from one net namespace to another, we move
> the
>    RDMA device into that net namespace
>=20
> What do you think ?
No. one device is not supposed to move other devices.
Every device is independent that should be moved by explicit command.

Also changes like above breaks the existing orchestration, it no-go.

