Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 736BB216156
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Jul 2020 00:13:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbgGFWNS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 Jul 2020 18:13:18 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:17376 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726625AbgGFWNS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 6 Jul 2020 18:13:18 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f03a1940001>; Mon, 06 Jul 2020 15:11:32 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 06 Jul 2020 15:13:17 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 06 Jul 2020 15:13:17 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 6 Jul
 2020 22:13:17 +0000
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.174)
 by HQMAIL109.nvidia.com (172.20.187.15) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Mon, 6 Jul 2020 22:13:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FiM+E/EUAvjPxTz39LF3zQslnGrJnez0Lld6q5DJo/0Y+u/Zi/UMHtCj0W82JeVsBY1GzmEW9Y2KBGKIva3BrwGx7Rz2jzCUlxz0tDSIZo5EZsC38dTOPzScSgtF686jfG8d/Xd+LEF+5ZfxYuTYSVYknzy08DM8IKtYOgGjp/7UTQsfXFDGHwd/LO+dtZKOFkd8EDTUVRH4RrOxa9g2n4X3ZozroIcGHwsz9XE4UwvW9GJDDfzVh5PO+zUeJLAtymnW4abhumiHo5mVogcV5wu4xUs8f47cl5oFEKlA0M3ClMNa85dQD35b1M0PENVSOTT/4Z9alcQpwFDWM6zy+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k6TlZuVotypFvjA6W21f3KbCOZyav8LwMwXjALVABn0=;
 b=TOP7i+7ygva7yVAlgq6iXbhMKM5aUxd/w+k8QcV+gW/KFL3C/qAtnMTypoNh/UKCRzdwQp1PhlOMqqns8u4AShEuVZ2Zy8keDwief2T/4XHGXLyRhhd1LaVdkcbti2LfBYbwa/von79568d6RQyWCWW8BBeZefNkhURnjuLrmzezOEcj7Xh4BnLXxDaCzVxiRIr4XXgoEHrlW+79b/MYxQ7muT25IxQFPdaj9OnwPPiq2exP8jbnLvC/R9ZYsg5o5bBV4K2cCrEjhb3EH/U17Uorb+qI4JBHWXkJ3pulyQH1FitW18NEFJvtfG7lURuR9n8C3YQze+JMZkfUCDLMlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB2810.namprd12.prod.outlook.com (2603:10b6:5:41::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.29; Mon, 6 Jul
 2020 22:13:16 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1d53:7cb4:c3d7:2b54]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1d53:7cb4:c3d7:2b54%6]) with mapi id 15.20.3153.029; Mon, 6 Jul 2020
 22:13:16 +0000
Date:   Mon, 6 Jul 2020 19:13:13 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Chuck Lever <chuck.lever@oracle.com>
CC:     <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH] RDMA/core: Clean up tracepoint headers
Message-ID: <20200706221313.GA1232502@nvidia.com>
References: <20200702141946.3775.51943.stgit@klimt.1015granger.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200702141946.3775.51943.stgit@klimt.1015granger.net>
X-ClientProxiedBy: YTXPR0101CA0056.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::33) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by YTXPR0101CA0056.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.21 via Frontend Transport; Mon, 6 Jul 2020 22:13:15 +0000
Received: from jgg by mlx with local (Exim 4.93)        (envelope-from <jgg@nvidia.com>)        id 1jsZMP-005AdX-PQ; Mon, 06 Jul 2020 19:13:13 -0300
X-Originating-IP: [206.223.160.26]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4558b5ae-fa9a-499d-c240-08d821f9c7b6
X-MS-TrafficTypeDiagnostic: DM6PR12MB2810:
X-Microsoft-Antispam-PRVS: <DM6PR12MB28106266CF1B218549772828C2690@DM6PR12MB2810.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1247;
X-Forefront-PRVS: 04569283F9
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aSsveoueQP3/C/3wuxT7B9J1qZ1HT9C+bhOw0V4Z1biQhGLdtk3kuDu6YV2oVkA7Sw5qetCFrnrCw2H50B+NmpO2O54KCelcWa/fgOzWOy2Jyl30n3/Wh2pBtrP/NokKRC6efTYD9rzBJsOwmBb/Q//vPF3VlXgDP8kWH4FhwJyWhdDYTHU9tRwsS1DSm3Y8mZrtkKGXIhDJyS6jC9RohUdxRik9ccrAAZsZPlILEwum4A6a2xvppEff4aJPG9MZkkZ1M6EUrFdpbMr8gDkLv7zq9eJxDcDtWLDuLsQEqRD7Ufac9KhaoeDXZd4xk1HgFMhNuqdFr7Xt1MDY2QKlDw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(346002)(376002)(39860400002)(366004)(396003)(6916009)(86362001)(66476007)(66556008)(66946007)(33656002)(4744005)(1076003)(426003)(5660300002)(2616005)(316002)(83380400001)(478600001)(9786002)(36756003)(9746002)(186003)(26005)(8936002)(2906002)(4326008)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: oqkWisdmlS+CmsHizsyTds67yiWmFqXjBi8mhFYVVNPDibZ8t+1UCplgON5b0BoGcXW0PI2zyw2341lX2oEaJjmWRpfIjIYrP3dAQGZuBEX/v+pG5/Vpy8IwRLCmHcs5qDPlQMIOr8E/thuR1qqhwwMo/IYm8p/dOYIGoQKI+6lxdNOLQW8THALku9SjRN7LsAa+rJA6kGLNZ7qTxYgpc2FLXkiQ8x+C9Wt+/pT+SQTnOXkmcUebshgWPhbCFpQXsHfkI9Zv/IjFJCsONTTlmYFMg/ZJ05pjI1MeZxSlFNJdJLZMzKp87W0jJiDQvavwZjvQguEBbPuqrBNCmrOwWT0E97CTw6gPwNV9I9sA0AwGaH6zwgPAn8VgXlP2zlYs/yzqVa7xbry8dEAfp2yB7kdt+rZcTl86r6HcMvVLjIOjqal7UogQX4Ds8u5PiAesmYZ6MjZeXFO52V6NVnlnM+s0s61Aldc+s92k/ScnA6sQb7FyExguKCF6FOGG5+mp
X-MS-Exchange-CrossTenant-Network-Message-Id: 4558b5ae-fa9a-499d-c240-08d821f9c7b6
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2020 22:13:16.0238
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5/2e9z9kCpduIojMrmRFrgXBl74kJXrokzhN6ztjKizdE2WdkhX1BdvD/wAWdc/p
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2810
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1594073492; bh=k6TlZuVotypFvjA6W21f3KbCOZyav8LwMwXjALVABn0=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:Authentication-Results:Date:From:To:CC:
         Subject:Message-ID:References:Content-Type:Content-Disposition:
         In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Originating-IP:
         X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id:
         X-MS-TrafficTypeDiagnostic:X-Microsoft-Antispam-PRVS:
         X-MS-Oob-TLC-OOBClassifiers:X-Forefront-PRVS:
         X-MS-Exchange-SenderADCheck:X-Microsoft-Antispam:
         X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
         X-MS-Exchange-AntiSpam-MessageData:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-AuthSource:
         X-MS-Exchange-CrossTenant-AuthAs:
         X-MS-Exchange-CrossTenant-OriginalArrivalTime:
         X-MS-Exchange-CrossTenant-FromEntityHeader:
         X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
         X-MS-Exchange-CrossTenant-UserPrincipalName:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
        b=FyYyrgydWIUBn+hVtK2MlfwZGmSLedzB8FsErxu77bu7J4rUCNNaaGEG2Ujf0Vah8
         Wztp6iwuJepudzV/hEzDhzE2wX89rtekSvMQk0XXnYGVgob2Q+MDgJmrhIlXfNcY7f
         Do1GtH5Xrll4CfYQy10FQ4S6FuXZpEHVhffKF4s0gbqva7bB5px3QD8Pt1O1nzwTYn
         iou6fZ8cgPIxUIgym9ENweT5bUaFKSFLFCI9McfNMubB119GQoFE6iUr9uBwwBysmc
         TOMiFp1bt43dSWMRignZb7qxVs4mC4abirbOGxC2RV4nDzvMhkjhMbsjzT7n3vcIba
         4vpRp8EK4ErWw==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jul 02, 2020 at 10:19:46AM -0400, Chuck Lever wrote:
> There's no need for core/trace.c to include rdma/ib_verbs.h twice.
> 
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> Reviewed-by: Leon Romanovsky <leonro@mellanox.com>
> ---
>  drivers/infiniband/core/trace.c |    2 --
>  1 file changed, 2 deletions(-)

Applied to for-next, thanks

Jason
