Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FF853FF7F5
	for <lists+linux-rdma@lfdr.de>; Fri,  3 Sep 2021 01:38:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345805AbhIBXjz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 2 Sep 2021 19:39:55 -0400
Received: from mail-dm6nam10on2063.outbound.protection.outlook.com ([40.107.93.63]:51839
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235909AbhIBXjy (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 2 Sep 2021 19:39:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f1Z0wLEvgNyMhL9pU6fELBodfiNOt+UFLBuIx6qgAfhZ/QD84qgrxUt7k3dUtGnEj7fqjn3PWXE8Kics1XC9S19Ov/IS8D8q5fXrV8Att+xvesNamtDJOpTRsM8TMW6kHxhMd+sf8gacx2IlqTZ5iwpu3Zf05Q4Znc7x0AaiNkTqay1odqa2Gz+jk7MG6nTNM+Wp0tD28i8iCvxUWaqkQZ2Fp31Xw3GEdTPswOxGjKk0+mnreBcDPeYIyJ/AtgNNMVJQzEIMRQgtDP45iPwdVDB+4+060NDUUKaF0EezKMC+dN3v6u44duHRSDMh5nYBG7TdFuOh3bBwBYJ4ry59+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=j+dVEqekv0D44YLa5gbVWzWMOC5MJjqzKOJrpU+fq98=;
 b=cQr5gaOVgisq9l/ogmTwqSbtZ3+ZuTLz94MAEFaTtjR03xC+RJ5xfsuJgoFDZXxf+GmbfG4UmHPBSLepWQCMZx0SXbZ7zKj8X/SpiGG0idB6rZeoVTkj0tj7enZ32GTUAm5m6g++Fh4rU9X2nDC8hNy0jWBYwSpZsQx2YwPKnzUmtFFPHd+7U3f4XULC5vTJ+Ti220j5gO1qRLHxjZH7xdrG8pIwIpz6lY/wv/dSZLQlhg384VHGIKvU3d00BPImf5tS2caYOwu72f/cR4ezghKx94ySqaIQYUnWlbrR0/xmvTlpu5A/LFBKWEKZ+6L0KwD4eOqn9N7fgCOw2O6dig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j+dVEqekv0D44YLa5gbVWzWMOC5MJjqzKOJrpU+fq98=;
 b=bgQx1t785EiftVzNr+ZC+EE7zZr7mzulP1W2iLpSJHCtAPPBax5KvVbAlcY53TkzsaPHlat6HhGGzn/mSi3NbwgnZen/7c94Yadonfvz1c0RXqJ4ud/7CmCWoehrUiaUDXkOI3LNJw/FlGcGTdAUEEKlSYhzbZg8EVn1iLEBkNio1wRCOM3WNzX6p9vfctFeWBcMTBEGGyy5z3zCqd3nJ/eG7F750R3x007UGMjBvq2GczhBq0XbEiuzBBjxaurf4Ej2P0aev2TK3wmi9F/28TbAlpaqQajSM/XBHDlDlx2HYG/+LQjuJhHVnvlWMXyUFTdtDJGziElPuJB3sAYBvA==
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5192.namprd12.prod.outlook.com (2603:10b6:208:311::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.21; Thu, 2 Sep
 2021 23:38:54 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95%8]) with mapi id 15.20.4478.020; Thu, 2 Sep 2021
 23:38:54 +0000
Date:   Thu, 2 Sep 2021 20:38:53 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: blktest/rxe almost working
Message-ID: <20210902233853.GB2505917@nvidia.com>
References: <c7557529-d07d-3e35-0f03-2bbe867af4a1@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c7557529-d07d-3e35-0f03-2bbe867af4a1@gmail.com>
X-ClientProxiedBy: MN2PR07CA0013.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::23) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by MN2PR07CA0013.namprd07.prod.outlook.com (2603:10b6:208:1a0::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.17 via Frontend Transport; Thu, 2 Sep 2021 23:38:54 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mLwIH-00AW0F-A8; Thu, 02 Sep 2021 20:38:53 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c2d783c3-6433-4d26-06f0-08d96e6ad370
X-MS-TrafficTypeDiagnostic: BL1PR12MB5192:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5192120089A9895A9D5D6FEFC2CE9@BL1PR12MB5192.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nQ7QGR+Spz5Axnj+p1bUF1baPyyrR5mT1gzaH0k23Ur2M/Kp6hCdcHhZVmMpj/B25crn5XPNitKA/HGCLpNokTM0n2Lr1B1xSVe+tf1V/JKapTd9eFb2jrl3O+94sg/Q5Aso/2jaheGwXtvwmLG3Nz0ri8ynNj4JlD5ZZW1YDVfiPATYltJatzTxRIHHbuKXVYA9jEzuxv6sBT1dC9p10IFmO7wGqxXFjiev4YMayoaIlx9aFXG9HkiCuBQIcJeGQPxgbI8Lc8lkg0Po9w0LhMYnh3zikVUQnDEypfcpkbRj3ebS8g9jqmlKV75oYOYRgM25dbVQage64mmx5AkibzOJCCFtoM2SiBlsppxUepy8s2ekBCglgyCdWPloiL5IfD5+GqAEbczQg+rYJdr980Zc7Bm0+eOYOkl0mfOW8KHrcw2dud7hEOd5YABSHoZhzpyfwUwLqaRQ+SS7b6oLSUjPWmd0XAHRCSyZkXWfzmx+3LHSYxGc6I5feEHV7T2vSNgS6GfthJSHAhNRdngBGEuICDiMIbGx1lhWLWpt8S5+ubtBQG9ZNYd4Z5DhPRctkUkBhUawrQaUlcfZGQy+5i5seDuZZBIYiIukwGqTyttwb2FszJbs2rX+kA5uJDgeuHYA5iuuA4EtHU+XW1t9cw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(396003)(39860400002)(346002)(366004)(478600001)(8676002)(316002)(6916009)(2906002)(1076003)(86362001)(3480700007)(66556008)(83380400001)(66476007)(66946007)(26005)(5660300002)(8936002)(38100700002)(54906003)(186003)(9746002)(36756003)(426003)(33656002)(9786002)(2616005)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SFwqa2a0sNxFtWw0oaoUiQc9gtjqhFldTyaLNxvulW6L6GerAOUIxJpho5XT?=
 =?us-ascii?Q?XFnoBMxk+C8QIiiGO4mJxFTcec13tzS2By0wygrHDFvJiTvRrl+FbSeGuIp1?=
 =?us-ascii?Q?lh2bf5KffJivgozbVHGgZjHtwyg9F0TAUogU5sqKHZqHj+itKeb39dpr2jpx?=
 =?us-ascii?Q?YBEVUVYFKJN+P2bvHfSjEzaoO75Y8nuoylDjRqv1PQFywr2Zk1Ph0u0RZqhw?=
 =?us-ascii?Q?17pamtBsFlrddbaykRw2L1oaL+9wZLesmZNCwpAleyuLjGTEl3oP8/0ETeOt?=
 =?us-ascii?Q?cRbQwzFAhOwogBhMT0gkBnRZsGWBapDKVgQPC+ukOQgvO0nEd+UbB6SRwrKU?=
 =?us-ascii?Q?aObnsrKE+6lTGKM9AxK1fKAfGNa9xRENQw+FA+Ln6BNbjlgqQ17vOIS5PX4R?=
 =?us-ascii?Q?q1bq8FwPwFSWd3qEUUTLWrT8zbHb1ysejAmKZMII6kCRib9gZyKojMtwegw7?=
 =?us-ascii?Q?MRi6xNUOXnQIENuzYLzn2nKpcqU+8X/A7ObGxW/rvUqVo5JL2+9HlSBk4j4i?=
 =?us-ascii?Q?S2TRt4UCBkfKpcNZ+6iOMEIwIzQ8aadHnvmDPRndU9i0oKp7NjivaW0Z5a74?=
 =?us-ascii?Q?Ot2v4Gg6Zb1hjLVUeCYVsTXZ2+jSsf61gEU+NeXfGE0u5+w61y3U0fQpa5Tz?=
 =?us-ascii?Q?fnqr16krK7VYw+nnmcOs2xwJ/LN0lGf6Rnxyz8FySMSYJjS9Vw6wGjNOHF5f?=
 =?us-ascii?Q?HX7mLXVmGF0QH/dX/JVSff8/9FxKSqXcNE6ge8JIoDq+T2TeWXPsdTzRvUGZ?=
 =?us-ascii?Q?1mGI9N2+mk3EHeNhi7bj4tRKsUG134DcLWkcpXFmbvtW/4TR4uuoKwLVEhRW?=
 =?us-ascii?Q?N8DJLL0Q4r7fXANhEGOowOYB0iNHoUkv9pggjt/XoagwtbC1AgZ/VCCjn1vP?=
 =?us-ascii?Q?qeCs3dVzXovf8szkafa9Y9k1sy8wzv39rS7aXwZDDQP6Xo+wu6y93ZFoA1hk?=
 =?us-ascii?Q?qJKh3SxKnmHPq/3H6LhiQLMSd+uTbWQGOKkIDfxIxmdQh+bdc8zGNjQuIS8F?=
 =?us-ascii?Q?fIrCSsvEHLUzTxzfLVONs5PqLa/1elxauGxrcTjUICFQtFr89eZdxe4ZTlMo?=
 =?us-ascii?Q?nNKafaDIaPzapADgK5kmsdNCrUrsxYDRNyzb6wFyu2T0rmM0DzsEXCJSWmAK?=
 =?us-ascii?Q?0aNC0cgaJrNWPk/fJ2jAQ0sjgnZv+rSZQAQr71J7tF3ho/VV04lr6+X3okGb?=
 =?us-ascii?Q?c37/+3Ygp8S/czuVjggEexDlas6QHWo2RztSCR7cIGlJNgNMo8PX/wu4FDvp?=
 =?us-ascii?Q?0u39PM31oZpiExnxJQL+pmwHt4Y2ijcUMOFXWQEyPdkpx6kmebJ6qoej6+61?=
 =?us-ascii?Q?c9winLuJtCeOB4mHoaDEAJTFYUmWbT38WyCEdzcIaFSGZw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2d783c3-6433-4d26-06f0-08d96e6ad370
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2021 23:38:54.3504
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qp0B31uSZwJtasli1WKy8nQj3Yd+lO2l/aX7+HaOJp/JWxAvwhFjCYKyGAHkrSYu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5192
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Sep 02, 2021 at 04:41:15PM -0500, Bob Pearson wrote:
> Now that for-next is on 5.14.0-rc6+ blktest srp/002 is very close to
> working for rxe but there is still one error. After adding MW
> support I added a test to local invalidate to check and see if the
> l/rkey matched the key actually contained in the MR/MW when local
> invalidate is called. This is failing for srp/002 with the key
> portion of the rkey off by one. Looking at ib_srp.c I see code that
> does in fact increment the rkey by one and also has code that posts
> a local invalidate. This was never checked before and is now failing
> to match. If I mask off the key portion in the test the whole test
> case passes so the other problems appear to have been fixed. If the
> increment and invalidate are out of sync this could result in the
> error. I suspect this may be a bug in srp. Worst case I can remove
> this test but I would rather not.

I didn't check the spec, but since SRP works with HW devices I wonder
if invalidation is supposed to ignore the variant bits in the mkey?

Jason
