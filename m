Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A423D38B33D
	for <lists+linux-rdma@lfdr.de>; Thu, 20 May 2021 17:27:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232073AbhETP3A (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 20 May 2021 11:29:00 -0400
Received: from mail-dm6nam11on2078.outbound.protection.outlook.com ([40.107.223.78]:45856
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231483AbhETP27 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 20 May 2021 11:28:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=deZLJFh2HA6LXc32S9y+h8Iw1l32PLSu+E9rZ/JaIYUqVwcatLyBq5HeCyAyxVT7kfWnoEAx4r2CzM6biSOBS5ahkwlUNmDgEMq2e7ebp8zKqhfYqT4rBOfk3TDlOnERxIhm7+LRFjz5GGB7qfDOoS1saSC1ANTzOpBJLTCr3JBIARAo+/myHjenkHQH/tPTPgjik/Uy/+/y9dzp3ycH79b7S/CloiGdaWMTRk5muq0CFch3h2KvjCrclr5b1xQYBfTTVObqaQCMXr6gafsfNX8AQm4HnkFVyT3qcRbWvhCvhDmsqx1snmAIwfLpwcgFZuk4YnXU/tuVJ+XYRSwJXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=20j17k9RM4wf/XquB8DM7YZDlImqvVgaMaIaVU6j8Ac=;
 b=BYBEMTpTw0EeHZwlwaYSGjdNzGSWBe1L1Fam1vDlLVG6myad/+TPcc8OAhD4py9/fukZY0nrk4pw8IfyhwoctLARt/fFsvBUS0vfcv1mIdrPeF2z9Xa4uiwPwQwZh5/JyLXWWenpK0ZVbRjiQvzF1RcOaUezn5a1bvfO6CYoW0KHdJCMXgu0+mRpksGsxeqg3KcKrilOE3bcSNVKKy3iXKTqg0EqvteoeOwk8QNXp92aqZhivut1eY0OYFVFwnYEAkNl8EwXwUf87+sdwTcyUkW7pm6p5KQMIiR6fZbSg1JllNl6JHeyzc+Oyw52zmsvTNN/7X5sLx/6jryz+ct0SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=20j17k9RM4wf/XquB8DM7YZDlImqvVgaMaIaVU6j8Ac=;
 b=IacnP4mCHs/XM2iuec0tWsh+rqnioyN9IwCGJAdExCUf7dsVCQozrBJt/9JOR6L856jmf3mJcrgUOJT+K8rjw7cPYFM9Z7T45waIVbWk2FRy+Y86jkTCilZ/tHFAYqmma7XChVcW2SJRdd2sDlm/y3dkqNmSoePpgmvO3jITdl/eSg5vh8oQ8sw/3P7q7AlanBgG02pWr8PGKpfRFNsK3ZP8teDzviZSQ0kKLt2LxzySy9qPayM9zydNB+DwZFGWDr8aXv7ZyP+MIk8Pfev/Cj82wyiPCAsnDG+UupBlhav7wDZNbQOm34h0GRKSe/Ge0bDm8vrkUmeZqTAEXlD3ow==
Authentication-Results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3401.namprd12.prod.outlook.com (2603:10b6:5:39::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Thu, 20 May
 2021 15:27:36 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::ddb4:2cbb:4589:f039]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::ddb4:2cbb:4589:f039%4]) with mapi id 15.20.4150.023; Thu, 20 May 2021
 15:27:36 +0000
Date:   Thu, 20 May 2021 12:27:35 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Doug Ledford <dledford@redhat.com>
Subject: Re: [PATCH v1 1/1] infiniband: hf1: Use string_upper() instead of
 open coded variant
Message-ID: <20210520152735.GA2742506@nvidia.com>
References: <20210518124111.20030-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210518124111.20030-1-andriy.shevchenko@linux.intel.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: MN2PR12CA0001.namprd12.prod.outlook.com
 (2603:10b6:208:a8::14) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by MN2PR12CA0001.namprd12.prod.outlook.com (2603:10b6:208:a8::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.23 via Frontend Transport; Thu, 20 May 2021 15:27:36 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1ljkaF-00BVTA-Dj; Thu, 20 May 2021 12:27:35 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1e2bb8a3-fe33-4205-6882-08d91ba3cbf6
X-MS-TrafficTypeDiagnostic: DM6PR12MB3401:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3401572890236594027F4B70C22A9@DM6PR12MB3401.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2657;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pNto29JZreV2Qqms+5MBjgRN4ZDb3ZZkp4rwmFcpXE5jsM3C9tf7tyLiTz9qeiokhQnIGAmw1Ngijp8jbE2oU/2e1KttaIW+rWTpZk95SsVdb04BGMO4gSH2qQLKMsgpcEAZ6bafQ7AGjmfD0Rpag3KC7G6iIdSqH7kaRKAFQQ554np93x2buV/LLQ4jOdxtCFJBuTXo40V9hsiE+2Pn4Fju80wPK1SBrzFMMwuKxgspR+HwEYcO+zaXFukekyMhJlq/NrZO0yc4eJrfJmzJZDg04ZjJQ6M9QPScJkKLTIdKLTzZrhWOLvDQfwoa+W929BYyGW2Z2hX0JLFtd+WslEQdxhsGhsmMTjoFNckwlVDTjjbzT5tJca6G/ZyaHzvGrfHnWErS+eQ3NXRZAprHFpVG5qxvWWIWwQ0PcD4HhJgVy3n++61p6a7Bbo0jAQwmgznin9WvqSIOm666P9yT1Nbs8/eXIyfmqwB9/uFfLQcQgjdd1zjb0LbCowT4IeHDbrHRs62RGEh9UpNw4ttwc95rmzqvoXrFPkuM1YzeAWVj8isqBR2Goz5jiGcRa/tOqDXKbkH6+kzcvY1x/nMfpFcZnBFLVoO0Ap18SLlKlMc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(396003)(39850400004)(376002)(346002)(86362001)(478600001)(5660300002)(1076003)(83380400001)(2906002)(186003)(9786002)(9746002)(6916009)(8936002)(33656002)(66556008)(66946007)(66476007)(4326008)(2616005)(26005)(426003)(38100700002)(316002)(36756003)(54906003)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?YkRwVHJiKzR5UDdKalViMkl3eHA3ZVNXVVF0OFlpQzVwVzBkelNKeU1ZbW9m?=
 =?utf-8?B?cFdIazJjbHczSHVyaWVzMkZhOGFNc2FnYS9uUzVnS2RRVFFCZDRUMFJJQlVO?=
 =?utf-8?B?MzFxZ0tKM0NvdVVqUStHM2dFY0lHWHpMMzhIMXhSK1h0eFZ5UldrV2RiaUJG?=
 =?utf-8?B?dzdLY1pTa0M2S3B2b3dWL3lLay9GS1JQSHhIWVJCeVZEY290Y0pCNklQZyt5?=
 =?utf-8?B?Q3krb0ZmZTlaMkl2YThQMG1TMjhNb3J6SGZEaXRJK3Zhd2dXTlNhdVdtSm5U?=
 =?utf-8?B?UEpPSGNUVmZYZU52MHpqRHpWQkMwaXBDbEpUOE9TNDFIUnEyWUlWVG9VVGE0?=
 =?utf-8?B?T1NaR3FIRU8wWTEvQzIwWENkeU02L1pKQ2FEZHNFYUJ2VS9lbkdoNVBiay8r?=
 =?utf-8?B?T3lqNWZTd0pYRi9wdSthRnMvRmlheWhwUW1pUnd3SHpGMjBsdG5rY1ZwMWhF?=
 =?utf-8?B?Znptc3RUMDNqN1ZYMXhaMXNna1Nab21iZEV4NHVkWUxSOUVXVHE0dTVkYWhM?=
 =?utf-8?B?WElVb2VZa3dGNXNXUDFPZ0hYN3I0b051M09EUzV0dE92bjhSaE43OWZFUWQ3?=
 =?utf-8?B?NERZL0xUMFVaSlZyS05OSHVUZVpmQ2MzSmZtcGluZkQ0MUpEVEdxdHdSNm1C?=
 =?utf-8?B?S21NZUgwKzJmSi9UTmkzT3VUMThHd1Y4eC9ydHBlRk53UFZIZmZUbXAyYURP?=
 =?utf-8?B?dmE4aGJDWElqbGZEV1dUVko2aFBtTkVCeXozOUErdDFubk5jekVka1pwMTds?=
 =?utf-8?B?N1VuKzVwK0lDU1cycVlBeGtrd21weDV1d0xyZXQySG5nb3p5V0JNWnFaUjd0?=
 =?utf-8?B?aFFtZ1ZQMm9nSVB4dHRjUlBqZXlETWZVSlBOR1M1UzE2ODRvRXdoY2plSEhF?=
 =?utf-8?B?WG5SQ29mbmlZUmhJUFpxWTc3akVvTFluRWhOWFVJdXR1OUhDVnQzb2dhZlVY?=
 =?utf-8?B?N282MkNzWkpmSCtoL1lSYVpiRkNwbS9PcDdEbjUyN0QwSUNGMUFIV1JabThx?=
 =?utf-8?B?TFZLQ3FId1RPTWdQUGZWYTdSOElSalVmN0hZNWRYVWRVdUwxdVpyenQ1RmU2?=
 =?utf-8?B?ZWZrUzdWelFZS2QwaFg5NkJVTFZjbTkyZGRDcDdtMzRHbGdmdFkySi9tbkl5?=
 =?utf-8?B?d1BsMnFlQ1dYU0d0ZlF0QW00Nld1WU00R1JnbDl2eXNodVBmckhSU1h0MGUr?=
 =?utf-8?B?SWtnVkdraC9zTnUwSnJFbmQxdmROZjc0WVBYZjZxT3hsOXo1UnJPd1dlWHVs?=
 =?utf-8?B?bE1lV2E5WjJPL3IxR2VlRUFKRFlhOTg5NmVKS0RRQndYS2ZrSlBVS0U0VWQr?=
 =?utf-8?B?NWJqenJYL1NkL0NHeFZhTWdHamw1Y1ZEVy9MT0EwN3VxaXRCUzNjbGNJdnVW?=
 =?utf-8?B?MjN3N3FIK3liSHY0YjJFMUtIRGI0bkpRdEYvWVhlUzJVSmxNektwQTdzTFRO?=
 =?utf-8?B?c2xIek1qYy9veFdPSjRSU2NsdGY2dGt5bzkwS3NKUDdXQ29oUFRpaFh3ajNV?=
 =?utf-8?B?NTMrTS9GTlRyK2hHaUo0aVJvZlRSb3dGNHA3VGZWL1NzNDQyUFUxVE5IRTg0?=
 =?utf-8?B?M0NUS1d5VHRQMEl0clp2bGZnQ0tsUFd0ZGVUVEw3U24ybGVGNGhqMFZzbEtN?=
 =?utf-8?B?Z0JkN2RoTVZNQmRqUGYrc2NtRzI4Q3AweE9HSCtFSGFLUGg3MWdvY0RGMGhY?=
 =?utf-8?B?aWxqMTlYUllENkZSZ3hJc2E2Kzg0alduekJXbHBGYXFiYzhNS3pVY21IdUdj?=
 =?utf-8?Q?5japgiioEcrj2SSo3TO89EmO3+oZKhjMOM8nZ2J?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e2bb8a3-fe33-4205-6882-08d91ba3cbf6
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2021 15:27:36.7347
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nkMlrVCEPlmyk/wUJJMw08bfkTae4+2zL9UYvZgZ1soiM3rVTyi0DnWcay+TqBdX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3401
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, May 18, 2021 at 03:41:11PM +0300, Andy Shevchenko wrote:
> Use string_upper() from string helper module instead of open coded variant.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/infiniband/hw/hfi1/efivar.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)

It doesn't compile??

In file included from drivers/infiniband/hw/hfi1/efivar.c:48:
./include/linux/string_helpers.h: In function ‘string_escape_str’:
./include/linux/string_helpers.h:70:32: error: implicit declaration of function ‘strlen’ [-Werror=implicit-function-declaration]
   70 |  return string_escape_mem(src, strlen(src), dst, sz, flags, only);
      |                                ^~~~~~
./include/linux/string_helpers.h:70:32: warning: incompatible implicit declaration of built-in function ‘strlen’
./include/linux/string_helpers.h:6:1: note: include ‘<string.h>’ or provide a declaration of ‘strlen’
    5 | #include <linux/ctype.h>
  +++ |+#include <string.h>
    6 | #include <linux/types.h>
cc1: some warnings being treated as errors

Jason
