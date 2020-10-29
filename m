Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EDFF29F107
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Oct 2020 17:16:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725859AbgJ2QQn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 29 Oct 2020 12:16:43 -0400
Received: from mail-bn8nam11on2078.outbound.protection.outlook.com ([40.107.236.78]:35264
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726112AbgJ2QQn (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 29 Oct 2020 12:16:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ve2zGfObInoPnixBfn7+cYax3mVOyMkmaFOaKk4nAq/15o65KKgAJvR7IiAcon2I/5loKk94EBAbRc8a8zXIZX+mRadZ/h3qK8TqPD3MImXa8OQklit4p6vN9NVxyCwIrjclbjG0wUjWpIxpVyStPXH9jJMW67haYjmlpekF5t604NpxOxqT6dqnDpy5pBrSd6xaJM1y+Rs3DK7S6Kmnoaou0a20tXdFa5Be0jCYqteH3sHp43IgYeTNQuW+uv/HaDULTNN7f+bgIhLfrklG49u3Q+QnGQNnZuotHFvg6twQdiVi6M2v5IGj4vuS539cegPpEhLiTIFRBVZQx8Jskw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+4wqyVomLCB/nNhmm1tH+OaCHOXcjNfREcz242Nv+RY=;
 b=H6QSmTEIxy4Pf61PGzRLZ8RvqOyrHzjseCecL9wiKN3VvIu4Wj9Z+RIq46dRoSYGeeF1094Pfu5NOH1jh1w1ZBOJw3/jJGqPAO86VyHvXbblt5BWHTrTDyqNwKMvtHsYI+qXpYNrs22E9H5LbGKhGUc+/ZIHLGXIzB/HAhMmsCTFfBiAKIHiqmNePhzfL0tHN3m8R1DRYnfIcxUATMup4DMv8u0xeHzGeDlGL4bqFP9KQ8CtykxwKx87FFw3CO6Q1ICEvobplTuH+x0URpt6AT8QX9ZQPvkkOzXeJst3JJN6/6+emx2sK8G1jFHFtDg8s7JQTW8XHFCtw5VTc42JRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+4wqyVomLCB/nNhmm1tH+OaCHOXcjNfREcz242Nv+RY=;
 b=2CPWxPk3WbHhgw9ajQnp1TZCDsirY/3DFnJjyvwFtVZs7LqnDHnuFvH0fqETfzqg0g8XxKOqUV5Wl/J+fnqM6pOTrdSRrwwc/XRHKYIbvVkNj4ur9WmRGeshWEyr27/CqeomiF/ID46oD1VviXrl9r1/Yt5rdJt+GddeNScFRYw=
Authentication-Results: vmware.com; dkim=none (message not signed)
 header.d=none;vmware.com; dmarc=none action=none header.from=vmware.com;
Received: from BYAPR05MB5511.namprd05.prod.outlook.com (2603:10b6:a03:1a::28)
 by BYAPR05MB5719.namprd05.prod.outlook.com (2603:10b6:a03:1e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.13; Thu, 29 Oct
 2020 16:16:40 +0000
Received: from BYAPR05MB5511.namprd05.prod.outlook.com
 ([fe80::958b:64f6:b2f9:97e0]) by BYAPR05MB5511.namprd05.prod.outlook.com
 ([fe80::958b:64f6:b2f9:97e0%7]) with mapi id 15.20.3499.027; Thu, 29 Oct 2020
 16:16:39 +0000
Subject: Re: [Suspected Spam] Re: [PATCH for-rc] RDMA/vmw_pvrdma: Fix the
 active_speed and phys_state value
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org,
        pv-drivers@vmware.com
References: <20201028231945.6533-1-aditr@vmware.com>
 <20201029115733.GA2620339@nvidia.com>
From:   Adit Ranadive <aditr@vmware.com>
Message-ID: <e0a834a1-e5ee-4838-4718-d6ded1e954be@vmware.com>
Date:   Thu, 29 Oct 2020 09:16:38 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.0
In-Reply-To: <20201029115733.GA2620339@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [107.3.164.70]
X-ClientProxiedBy: BYAPR07CA0101.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::42) To BYAPR05MB5511.namprd05.prod.outlook.com
 (2603:10b6:a03:1a::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Adits-MacBook-Pro.local (107.3.164.70) by BYAPR07CA0101.namprd07.prod.outlook.com (2603:10b6:a03:12b::42) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend Transport; Thu, 29 Oct 2020 16:16:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 108c248a-2fdf-4c73-5810-08d87c260443
X-MS-TrafficTypeDiagnostic: BYAPR05MB5719:
X-LD-Processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR05MB57197603E5DF848983AE26B8C5140@BYAPR05MB5719.namprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:454;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HY9mNCYdWuo7/zzhFdmpUJ2wvrbO8OKDeCBRFlGOPQNDXkjP3k+xjtn5UBxw+pW6volXvLs5tOPlmbQWpirrB9SDNimCGVExJeVIVC599K86IDi4lvKmfLz6JmY9xYRuNXeDiQeDihhRPcap4tOkhHMFpJcBTly+SkSFWd8WSv+WeH49jEnfamHHmDpLpxRq5FHGcvqIhap+LVU/FXOs1mfmjDO3E5JVEXgVsZAH0q1fq2h+kyRazXO2dRO9gFtjMSHg+Ort5zh24ekpBZhz3qEbPjQPfIrGL5QwxQTREv8Ku1iNxoPadZRHdwdtIrj2TSEj/Y6LzPFPl4XK9uDv4jnQVRx4ys4JTd84sVaMglnovisf6VQKYDjK0j5ln7sb
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR05MB5511.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(376002)(366004)(396003)(136003)(6506007)(16526019)(186003)(6916009)(4326008)(8676002)(478600001)(66476007)(316002)(2616005)(86362001)(107886003)(2906002)(31696002)(66946007)(26005)(8936002)(66556008)(36756003)(956004)(53546011)(6512007)(5660300002)(6486002)(31686004)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 47tKfTLhFXA1huJqIFaJjECXPPAcsnSUUPAQPfmbmdH6MTaZPr014/vLAn/XWYjXqrW2GnnEzsLRILoei9VACHyQig1Zz+1tt3lWyLvWtx7F9rjxYvsbYznqViz1izQYmGUw29pN5csPY5h+DSWaI4S/nhk7ZaNZ+ObPwwoZStvpYRyg4MKVgO1ueF3A1Njio592NJlhUQmnCoukYklSen6zTLYYBR5bJ5UOCAWNgYCLYEl5a7WtV9Rr87NLwILX39lVr8hxldcEorf6eHzinUOsTcIFkYJ+H6ASCRpSqKz0GbkGvO5fgUiu5KhUvacKBg6UmqehQY+I6X21OvHqXLaE32z6dAwE3KuIeXfK9CaoL+Q1i3bovjZEBnmJa3eJf+yqDZqZvV+2kgylrXix/kvJyZc9vO+RlqVAR5rM5lptP4ytB7ZFNPLzlyojik0pePX+rjLNLwo1sJHlv6xeCXqCfonTrncOicElPMhOHUe6VLmpWa/hLj5tei3RfBhlHgxcMMyuNwFVZCYl4g4lN9l+VjTM5k1yvgXtHtmU+kAkgb7mLAposaOTcGuhktqyEkrbdjIdBf5QY72Dc95JkCZVY6LK2eS6Yewq7dfpmNycgGGqyLvRgnTxiAE9BREnzHJHXkZFSuIfehDbGcXEHQ==
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 108c248a-2fdf-4c73-5810-08d87c260443
X-MS-Exchange-CrossTenant-AuthSource: BYAPR05MB5511.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2020 16:16:39.8277
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mp7ahDSi5BQaq+LTrTiClsk/Rh9eW7mQbBAa71TXlj9pJkVhduwPZY/p4P84/JDKZMNzE6lq5pY+7sbrdMI8xQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB5719
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 10/29/20 4:57 AM, Jason Gunthorpe wrote:
> On Wed, Oct 28, 2020 at 11:19:45PM +0000, Adit Ranadive wrote:
>> The PVRDMA device still reports the active_speed in u8.
>> Lets use the ib_eth_get_speed to report the speed and
>> width. Unfortunately, phys_state gets stored as msb of
>> the new u16 active_speed.
> 
> This explanation is not clear, I have no idea what this is fixing

It seemed more clear to me in my head, I guess :).

After commit 376ceb31ff87 changed the active_speed attribute to
u16, both the active_speed and phys_state attributes in the
pvrdma_port_attr struct are getting stored in this u16. As a 
result, these show up as invalid values in ibv_devinfo.

Our device still gives us back a u8 active_speed so both these
are getting stored in the u16. This fix I proposed simply gets 
the active_speed from the netdev while the phys_state still 
needs to come from the pvrdma device, i.e. the msb the of the
u16. I also removed some unused functions as a result.

Alternatively, I could change the u8 active_width and u16 
active_speed to reserved now that we're getting the active_speed
and active_width from the ib_get_eth_speed function.

> 
> Jason
> 
