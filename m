Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B6C035D054
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Apr 2021 20:28:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236868AbhDLS2r (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 12 Apr 2021 14:28:47 -0400
Received: from mail-dm6nam12on2050.outbound.protection.outlook.com ([40.107.243.50]:30625
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236853AbhDLS2r (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 12 Apr 2021 14:28:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LXAJhhMrgKKyFA3gVZG/cwgjlI6Hj4DvW4LgFwSz1lvPFbrKfzs6acDMSkAyBMVGl7I8fmMU2Phi+QfZaLFMFPYgILNkRIcIyusUWFDM8Wyvj1nXnt0d7mCNYDRFyBOcLhLzoaYeD6l1wKjU9G5LH66m9Y9A7LXKCgw2EfxYVYgyJZY9svZNUS/QDiHuQ6E3mVK8jSDYczreMJgWMOL1grmOrmp2/l7HeumuMa/ElXRXHpKzKnfvBjcnb9sV5kct3/75+61/rt8m/92e0SIMDVyrvPmbuXqy6Hw/9dbS4X29M6iPOllKkqFZEwiDGlER7T6zjLMeFZUQU0+75JQCyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5i+qDfbT0DacoXh56nYoDy7gBBxKUQpWowtRWxomhFU=;
 b=ZOLTRyShPVRU8BLaCgShd+0Y/cBOn+OcNu7xtIsO+bUiJh7CNIa5+QwVXf4TQj3U5tAPy/l2rYagWB8rvER93iw84yUIfW/GHKFjY0y4QC5xhMoh3uPtO4NXiXSUbJP8vhuz2iqchFjw88uBb2FLqz5OsxQLtC4tr9r4BMTyxe3cRSJEsCOoVHRI3U00EuKu2U9VUlh+tZLWMFaAH27/W4nLEEtMHyOBxQNbiPTgDe326BL+ide+EeCZANj7p2Tw757C+4domO1fy4y68bcRESixw2e32MISWHN4bojXh7OZGEh1yfx5UkxNbRFkZKbCQUhhRcNU9xQAcdzq8pJcUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5i+qDfbT0DacoXh56nYoDy7gBBxKUQpWowtRWxomhFU=;
 b=XSyG5rw+cBZ9nDeUJEAS8NctNS6qQP6/ZDpVpE8fi7bDakr6mHOSIpJIiBrrUIetSAeLOjr9JhfNjgMg7d1kY4RfyXr747ehHLaYymn68f6v7WhtP+d7rufXsy4tJyK7I0+INnr9fdMqgcaXSgHbxZcIUJfhYBC4al1voKV70L911PqkccI0+42ICEh66SswEbtypRM48V8L0O5V9z3nJpC8il0CSJzxfmulx0oQzZ3Sr2fgYE3s2RmaL4VanMxO1NDepY3GdnHvaot2pu5B98Jg95jPydQZK2N3CC/KiVWHUz43JyyNEIlKpp1cjOIUFYKERGc9K7Lv9+FBTzyVuQ==
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1881.namprd12.prod.outlook.com (2603:10b6:3:10f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.21; Mon, 12 Apr
 2021 18:28:25 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.4020.022; Mon, 12 Apr 2021
 18:28:25 +0000
Date:   Mon, 12 Apr 2021 15:28:23 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Wang Wensheng <wangwensheng4@huawei.com>
Cc:     mkalderon@marvell.com, aelior@marvell.com, dledford@redhat.com,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        rui.xiang@huawei.com
Subject: Re: [PATCH -next] RDMA/qedr: Fix error return code in
 qedr_iw_connect()
Message-ID: <20210412182823.GA1158895@nvidia.com>
References: <20210408113135.92165-1-wangwensheng4@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210408113135.92165-1-wangwensheng4@huawei.com>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: BL0PR02CA0005.namprd02.prod.outlook.com
 (2603:10b6:207:3c::18) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by BL0PR02CA0005.namprd02.prod.outlook.com (2603:10b6:207:3c::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.20 via Frontend Transport; Mon, 12 Apr 2021 18:28:25 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lW1IN-004rUc-PM; Mon, 12 Apr 2021 15:28:23 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c62fda90-61dd-4430-0820-08d8fde0c28b
X-MS-TrafficTypeDiagnostic: DM5PR12MB1881:
X-Microsoft-Antispam-PRVS: <DM5PR12MB188128057B7122435F348839C2709@DM5PR12MB1881.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cAq46BQgX+6T++0AV6SVJf+UA/CV/8CGSuGWsT6P7GV8GdFAp4XV1SDAI4Br8gxJ7P6lv6sfQEDUdTdNS3MkVdTdCnFYJwUCXslV+zAXiI+iYMi5DlPohYwOkttJHiRdytoPtKhD+umlLjfVKgxWx4aXxt5cC8RPl3wRQ+I3aEpjYilxd3vXiNknci/5Q+AvQ8v796gAoaeOq6qtscmXzE/1svU8VSVRYUa2qN9d6Azdx9w90hV+4CVGJEBMGLbzv0qoNJ4S7pDHtZB96FSYGZSxBWAFE8GQveBkjtyr3tNS9EbFR7zqtpSqsP4Om4akG8bPV+t/2uq5ws3YJM8PXAuwdCPfYtbMI1Ow/eGpOg0O+JRdBe6IdFc5Ko7xD44/4hgTiJFfXEYNuAx8JJXVqQVQOmeZel+3BF1nOqK0wFeAkhbk/GrldUjezNxMpy8IlPZ9qI6AJ9l38qQh1f2SloCQ3bQRPH4yQkMpPhx5gF8wg/n3J+chfNDmptrtmHw6EnVxNDkq3fYHDqtV/ai3Shp2lEI7bLPRYlULcW9jdvVM3rkRCC2L1ed1/bekGBs0y8xC+foVVz7b7bmTQ7JkkEJgiE6TXLAxazuhF94eVdA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(376002)(136003)(366004)(39860400002)(33656002)(478600001)(4744005)(83380400001)(9746002)(9786002)(2616005)(66476007)(2906002)(26005)(36756003)(8936002)(186003)(86362001)(4326008)(426003)(5660300002)(66556008)(38100700002)(6916009)(316002)(8676002)(66946007)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?dGRud1U1Nnk1bVVVclhsNS9QRTRSMm9mVmpqVklIeDVra3IxcUQ2VytjSzl4?=
 =?utf-8?B?RVB4bys3V1djRWFFRVRCZHR5UzVoRkUxWTMwL1E4cXNEUWptdmxVWGh0dFRt?=
 =?utf-8?B?bDd5M2JyUmRTcHhoU0FWaDgzcjhVN3VwWHpET3B4dko0QS9zSndyUzVkNnM5?=
 =?utf-8?B?cWtNRDNXZXVaYmI4Y2lVM25wWGp5UjhMYmNWSEJ2Sk81NmNpeGJhakpXZTlD?=
 =?utf-8?B?ZHlZNkV4ZDdpRTJrYUNCZWNOQzVGMkhnZU5tSysxQmZ5Y2JBckRNYThad0Y5?=
 =?utf-8?B?eTMreE9YemYySnVOdUJ2ZUViMm0xSWtzUi9yZzBhRjBxOTNtRUdFK2w0bG90?=
 =?utf-8?B?aldrUGp4MDhjM1Z5YWVNWkJuSDJnbzM4SkNKcXZ2OG5RNm0vZGF3SkhSTndv?=
 =?utf-8?B?QUw4Z0V6WWFXWDdUOWFMZjNhekgzT25FSElQVGJtai9mdzJ5RExZWUVxMGhS?=
 =?utf-8?B?R1dFR1ptNm5ESGRXc0pTNWZrZ0pzZDdDZFFPNE5mTlhCN1lQK2d0TVNhSjlB?=
 =?utf-8?B?cVB3OHd2Rnp6a3B5OGFKT2IwUE1pUVZOQzN0YytaTElwM2pxam9HVmsyRXNB?=
 =?utf-8?B?dVRLb2l6Z2JFWis5Ui9NS2swRG9DdlVFempQaVpDSjV4eUtFRXVnRTZ5NHAv?=
 =?utf-8?B?bWx6NWs2L1Q1aW9qV1RIMFpLd09SbzBrZXFtWllGTnIyS1ZUdGx4R2IwZDVp?=
 =?utf-8?B?bUExZzkveFh0ZW8xWVY0MmxjaEVtOWdoaDFkYTQ3YkpBRFBsc2JaRnNNNGMw?=
 =?utf-8?B?ek9Yd1loNkljQ0ZtaUtDYWh4dyt4Mm1BTzRnTHkxVjVxVVRCWjd4SWdDeFRU?=
 =?utf-8?B?emJ6Sk4ydFJzS2txTmRlYnIvSk1kMXIyTHJ5dGVXVTk4bzNrdmZoWHErRUM4?=
 =?utf-8?B?dnZqTnBPRElOTWJkc3A1T0tFMThpWTFWTUpJRmNVMXBES01FY0d0TUNLLzYv?=
 =?utf-8?B?NUtjbitWaS9zNVVEeDZMa2E2VlZRWXlXaC94ZkNnYzhkV0RiRnZtaDJRbEVP?=
 =?utf-8?B?OWJESk1ZY2FQNjhvYzV4aVlHbW1xdm5VVEl5RzVaNHV3dFBRR1pOU0ltRVhk?=
 =?utf-8?B?ZytTWUZ1YTJoV2dmdUhzdU1yM1dwaTlRd1dGTU9lT01qL3psc01BdHdiT3F5?=
 =?utf-8?B?WG00RjVyMG5KVVB0TnA0R243Z2taN0JaV3pZU2ZOaGZrYWhaaHJzRDBJNmJu?=
 =?utf-8?B?ZjA5MVpVRmx3RlYxa3RzVlo3VmNsZ3Q3WWcrTTZ2dEdDdWJiOWd5V2dJeXNN?=
 =?utf-8?B?ZW5FQkdreEs2Z2N3MytnK08vTEFqYTdsdWZlaVJwTk5lY2lHYm1LaHphczdQ?=
 =?utf-8?B?VzBnaHBwNmkrbDZVbVpyUjl2VXl0R3JzdEhOaVhqSTR6aFU3VDlpek9vbE1P?=
 =?utf-8?B?a1NoNkc4ZWpvVElFVXFQSVd6cFZhVFc5cnliQXk0eGJCRXpGaTlUVFZUMmFU?=
 =?utf-8?B?T3NLZDI3Zy9leG1GYi8wM3dYTjFyKzBZc3ZDaHNIQmxxRXduS0xBMk1nQzQ3?=
 =?utf-8?B?cC9wUnBiU3QvT1d4VlV3M0s0eUw5aUNKYWhLMytXSFlBZnlBU0NsUjF6dEV0?=
 =?utf-8?B?UzhFQkJrQUp3V1V4THZEbThxVGgvbTl4cEJjcDlna0FlNGwrS0t1NVpCMnVj?=
 =?utf-8?B?cEIwcHZMdHdValBVZ0pJaVNsaFk3emkxSVVOUUxJOW1SemViaEtlR2oxelBQ?=
 =?utf-8?B?WFcrcktxdkdXc2ZrQXlNUGJRS0xwZ1Qvcm1KWndUN3diODNwc01PTnlwM0hY?=
 =?utf-8?B?bmFUdWNPdDVMQStSdFlUYTVCaFB2WEFZeHBYVmNwZmg5UjFEdjg0WXBzd3k3?=
 =?utf-8?B?YzRiYytWZGZjbGNCdExKUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c62fda90-61dd-4430-0820-08d8fde0c28b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2021 18:28:25.3666
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W7zPMCCfb9HDZk2ZAdpq5BfBpOebtsv4UdF/XA3nMHicJmctX5XZuCV7AuMNy8Yu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1881
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Apr 08, 2021 at 11:31:35AM +0000, Wang Wensheng wrote:
> Fix to return a negative error code from the error handling
> case instead of 0, as done elsewhere in this function.
> 
> Fixes: 82af6d19d8d9 ("RDMA/qedr: Fix synchronization methods and memory leaks in qedr")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Wang Wensheng <wangwensheng4@huawei.com>
> Acked-by: Michal Kalderon <michal.kalderon@marvell.com>
> ---
>  drivers/infiniband/hw/qedr/qedr_iw_cm.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Applied to for-next, thanks

Jason
