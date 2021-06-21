Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B872A3AEB7C
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Jun 2021 16:35:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbhFUOhd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 21 Jun 2021 10:37:33 -0400
Received: from mail-bn7nam10on2079.outbound.protection.outlook.com ([40.107.92.79]:38368
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229876AbhFUOhd (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 21 Jun 2021 10:37:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O9wLAAs7ckOYZvN1yxJe7zZEo2u66U2l34SjNmrY5YGzSPPbyE1N7hZdbG6esD7INf5frllSf64bYiA5Dku4V5Jg/PILB+uM3hFFpw4oeDV0YmlrT7fLd3EcCx52ULKVNvmX7HzHY508cJbAHu30TmXzUcQfyS6su6mk7Hy1Oi3X8fMJmBPTsj4iTKziKy09TB1w+2DUCOJyIYWOcz///2MoO7BfDvJOjyPolzzkm7+rSqssgpIls4TpWLYKmpkPMNILVYMlwmsMS8pflIIVqsTViiQcr9HnAbfiuEiq9WCmyVkqBo4gHiE+Myrtns54PjQvGmTfxY13+ittXtoiZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Orvd/7bV5kzKidomnnuHzFrjVT0DR7wZvB8ZncbZcpA=;
 b=eAGye4JoDaCXIeFIOFQ5X+OYJ011ltFPoHooyiqO8Rt+rGpH/U7Nm1H651pmzSbo2Xqj8mOhZlSO5WN7sbPgBtOJwyslJWeeUgDbriyr2g5WcoWjXUrZ6Irc4/dklPT+ISRcBgpa6peiepV56rwuIgak0l+Fnzd2dzd153e7NDHnqJfhAsLkecL6oMql+j6JuKdIrBVLsJXqR76OUDZSJMoEq5OuU+IAZX7VphuNb6LXMjx05FvfFuVUsaZ1YF4/4tlJKp4ZttJxzCU1LtcATRlcnOaq0n7VzOTH0lu7YgCJamAvTuLvk6ugfT3ulZlG7Kip9CSiYev2EBn81+7NIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Orvd/7bV5kzKidomnnuHzFrjVT0DR7wZvB8ZncbZcpA=;
 b=CgQt4xEUXDH39HNs0CeyaraFWTlxzV4TR4LHvuCp0ByVHYjTRXfN/yvJnRLMVJi2pesMIEgILX/nBOKHfoJUG/w2sY7fHAqFeZyBC5BKhOathDnMaoaTT/KjFgKomqstqPmWc6jsjIa5RmBfw0aAMKG2mv4G1pSy8/to4GQAE/Wsz6mv0O4WZvRuukVQ/HF/hwXZADarwDeae+hX49UzAKZpdGtG68b4ZPHyRCuloyLf7wLxqrONmSq8HS0qiyXV6cYCumQ2lMsnSJgqk0ToP+bfUdf2qXVV+fqqQRDUMKbHbE8cmmxXWeE1RiGkfJmHRhSbzZ3VmMnbuvuGI4Od+g==
Authentication-Results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5303.namprd12.prod.outlook.com (2603:10b6:208:317::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18; Mon, 21 Jun
 2021 14:35:17 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%8]) with mapi id 15.20.4242.023; Mon, 21 Jun 2021
 14:35:17 +0000
Date:   Mon, 21 Jun 2021 11:35:16 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     =?utf-8?B?SMOla29u?= Bugge <haakon.bugge@oracle.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next] RDMA/cma: Replace RMW with atomic bit-ops
Message-ID: <20210621143516.GO1002214@nvidia.com>
References: <1623854153-19147-1-git-send-email-haakon.bugge@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1623854153-19147-1-git-send-email-haakon.bugge@oracle.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: BLAPR03CA0074.namprd03.prod.outlook.com
 (2603:10b6:208:329::19) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by BLAPR03CA0074.namprd03.prod.outlook.com (2603:10b6:208:329::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19 via Frontend Transport; Mon, 21 Jun 2021 14:35:17 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lvL1A-009X3C-BR; Mon, 21 Jun 2021 11:35:16 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e05d6a6c-20de-47c9-3657-08d934c1c9fc
X-MS-TrafficTypeDiagnostic: BL1PR12MB5303:
X-Microsoft-Antispam-PRVS: <BL1PR12MB530313034B4032DC5AAA88F3C20A9@BL1PR12MB5303.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5At7P/24pwLe9/bqwCsEIcwmI52rDfmLV1xAfvvqNtaWf3JXHXFCIZoSb9fJtUf6ErV8n5KZP0U+1bMGyrs/MkABXV64tg79dfCxoK0k6GxAZu/3JRfviFcTv2YIzaogxh/EKMs5iU7bjvr9Rdk2RyncCI+Uoc9NrgbOl6v9F4X1CHwP1GiJ6M4xuGopmYcLVwfVFQVNPf4cowDSbwi7pt9SszmDj4TeVEH9ispYcqTSrqjHJ8pZwJbqkzAZJ7IuiURqE7yAl1vANdHKNlRDFk07ZqVXVQOqzweTlJheK4aOvVyMuaY9e3GQ5V6+eBvEsm9INN3lpuXey3n/LlziXsGZNT+BUez83+SWxTbOt/cb7b0JqbityxffifRzDtVxz8+MREAP55dk+bAB+JCtXtwTL+kAEDY+X9rc6bdjt4GmFsFK4yt0bRnlDNY9+wuGbkV8MVZFYRhwMLR0JHHvMYJ00OFjM9WR7C7wXBy5aSe3O6dXOU4MBQEl2WDjTBDbDe6Sv9D17d54lzMXrfJnCbGrXEvGMwCXNRX/S/MgWaN2r5L/F7Z2Id37Oh8sPkShdDCy+F3AqSnE0PvEKhzsA9LpCvAOzeKnZV/4TsK21TY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(396003)(346002)(376002)(136003)(36756003)(9746002)(9786002)(66556008)(6916009)(316002)(426003)(66946007)(8676002)(4326008)(4744005)(66476007)(26005)(478600001)(5660300002)(186003)(54906003)(8936002)(66574015)(38100700002)(2906002)(86362001)(1076003)(33656002)(2616005)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cFVpcVNXbGhic2I0OW1NU2ZvRXY3UGhTNzUwbDN3akdtR2NtSnp5b3JwZ1BT?=
 =?utf-8?B?cGNCQzBtNWl4WmMzM2hDVXpFU0lWZVRwL0NlbmFUWUUwMTBmZ0NQNTlJYWx4?=
 =?utf-8?B?NzlVdlNCNzBkT0JzS2N0TVhUN0liaFBESnVNMG1kWG5VZ1NoaXNLQXo2U1Iz?=
 =?utf-8?B?K0g2d0Q5ZzhacFNzRkJCSHdVY3IrNGNZckxlZmRvUEhOTm1zaFRmRFpVbis5?=
 =?utf-8?B?Ky9DV1NEbDBrcEEzZlFvUXptK0E5aUlqZWd5cnhqejlGZXJjRlFsRENMNkRH?=
 =?utf-8?B?dGh3UGVmYWYxWGtSVlQ0S0FVOXhnMXBVaEU1R3lqZWZpQXNBbnB2eThxbGNp?=
 =?utf-8?B?TVJSVUlDQXVJMjN6UTc1L1pkVGt5T0xvRFY3ZDJFZDI4KzNhaXptRkhnS2hF?=
 =?utf-8?B?RGxiNXZmcHRuR2o5dDlWVHZuQ2NGWmlZbWJLVVFibVJHNkk2TElWL094QkQw?=
 =?utf-8?B?VnR4VlRickdtSXN0NUlOcWVJNGkyUlgxemd5NnYxNjFTSVBOd2Y5R3hOcEgy?=
 =?utf-8?B?YWp2Q1lxTXZsQVArS3dEbGFhNE04Wm5hWEV6YkFpZ3pjK1JiNkVnYWJIYmZP?=
 =?utf-8?B?NERlaldibVV1d1pXcG9HdExVZ2YxWDVoUFlEYlkzRWVJQU5sODl1d2p4RHZo?=
 =?utf-8?B?RHpCT2FZMHVLeXVYenlzZU9SODdveGJiL01vUi9HcDlwYWpDeVI2TGNwbXBQ?=
 =?utf-8?B?bG9PR1IvekJDbm05R093WmdtL0o5eG52ZUc3ZC9GekNrbzBDQ3lzczBhQW5X?=
 =?utf-8?B?YUJQWXBodDRGNnl6NnRDbDJQYVJBVEc0WW50MFNwbHZNaWxwU0ZmcXJYYXJT?=
 =?utf-8?B?L3RrVFBlOFdrUWgzUHA1dDdENkFUY2Q0Z1dhMWZ4UmVicVUvTHk2YStkM1lz?=
 =?utf-8?B?NEhYa2oySHpSM1llQWlSNVhKbUdqYVpOQTUyeitQcUhpY1NtNDcwbHZJQjMx?=
 =?utf-8?B?d1dKWHFmSW9RMGdNQk4zL01oeHJsWk9scU15ci9ucUpCc0FsQ0JuOVczWk1l?=
 =?utf-8?B?L3h5OWE4Zm1MMjNyVlVENjdzVDdudlg0d0Z6NkFLNVUyeFZ1ZFZtMTcwclhl?=
 =?utf-8?B?L2pXLzJ1NHJYMVZvdVVkeXJURzV3eHZvdVJXSVVhSXY1bnpwQlFja2hzY0Vs?=
 =?utf-8?B?OEZ3UXlvTzZveXAxdUJOc2ZiRFFXZnFKdWhCYlRMN1pOZEVRY2JkYzhycmNH?=
 =?utf-8?B?T3ZwMmdibnd5WjZYT251TSt0M3VmY0g4RHBIQU9pSmMzaFkvcVZ4TnY0Q2Vv?=
 =?utf-8?B?eldYNDJscGVmMkozc1FMMHhNVlEzbjdta2gzS2NwbWUzTSticUpZSm5nTVlW?=
 =?utf-8?B?cGE5STlDVVNQR0FBYkF0YlppQlJCeERvM3hnbkhxUDdZSjJpRkpBakpCY1Fr?=
 =?utf-8?B?NHdKVzJLWVk0dU5yYTJBQXlwTnpIc3BZcGwrTE82b2s3VEpWNW9NSTVCMXZs?=
 =?utf-8?B?NzVtejZ4dHVHUlI0cEpkSmRpblFac3lYMVp1RHVlL1o5RENrYnlOak5Za0t3?=
 =?utf-8?B?cWtyKzNqVy9rZ0xaVUFzREhxNG8xRGJvUWFUUUdxSTg0d1kvc3hwQjZUWmNn?=
 =?utf-8?B?c0cxbTRoREZCOWxWeThMVzdnNWpwU3ZnWmorYnZJeCsyYkFWZS9HMkVYSi9l?=
 =?utf-8?B?OHo5ZEVFd3JMTVZ5ZmRJbWRpUit4MUltUnRsQUxIUVdzV093a0U0SFQ0L3VG?=
 =?utf-8?B?dlF1YkVPeUJmWE9YVUlVdTk5NmpqYUFIZ0MwTHVUZ3hOUVBXSEZWNXR6K3lT?=
 =?utf-8?Q?cUsSx7xeOahxI3s/MfmkVGWLuNUqyqmS3t5gxZv?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e05d6a6c-20de-47c9-3657-08d934c1c9fc
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2021 14:35:17.4256
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1HE7iZBCbdxzVc+AjBSY3m1qoafQ9d3b7+04nmmqYCV5K/4VH0kxugzOJNck2L4A
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5303
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jun 16, 2021 at 04:35:53PM +0200, Håkon Bugge wrote:
> +#define BIT_ACCESS_FUNCTIONS(b)							\
> +	static inline void set_##b(unsigned long flags)				\
> +	{									\
> +		/* set_bit() does not imply a memory barrier */			\
> +		smp_mb__before_atomic();					\
> +		set_bit(b, &flags);						\
> +		/* set_bit() does not imply a memory barrier */			\
> +		smp_mb__after_atomic();						\
> +	}

This isn't needed, set_bit/test_bit are already atomic with
themselves, we should not need to introduce release semantics.

Please split this to one patch per variable

Every variable should be evalulated to decide if we should hold the
spinlock instead of relying on atomics.

Jason
