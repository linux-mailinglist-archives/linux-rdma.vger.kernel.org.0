Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6B4D2A3264
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Nov 2020 18:55:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725768AbgKBRzc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 2 Nov 2020 12:55:32 -0500
Received: from mail-dm6nam10on2059.outbound.protection.outlook.com ([40.107.93.59]:8480
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725791AbgKBRzb (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 2 Nov 2020 12:55:31 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hOa9OzOgnQAsQqv7vFIkN9m8sMXgBVlLJwEA8g6xL83PWVRxvH/lV5uXNfyCQ6DeQ9EDKJBm6tffqe54aCMA2my56emHH8GipBOEjBPlgfp9d5WXS8ueJkltjLtZjQEaJTEAs9bf50sj94iJWrV/YziTR44ph2QKWYEEd0sstM+p/puKGEs+FCxYz/dcT+rypbv/f5cptXGuh40uznGboKXG/qXq+b/iXn0RO89CAAK2vgdsmldWGDNU85WUREA6oCtyByXCJhEuFCNr5WboEngHPkTMDw32qur1Q7NlsoOkZ3lTvxmIPqxyeKlGOvRQ/GV2Y9FkPPYoRDyS/bwWxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qs/K+rtXV3H1G7OmRYYzm6Z+zZ3bqLmi/DvC0F/bNpU=;
 b=Ln2AO+EsOIPf0G/Ap+eqPOZ04qgwmeL0AzFkXaYII98AdbuL6ez9/W9oJLz+JS51XlXQx09qwsu9WsPklqv/U3hrOw4J2kyMEd7RrqDDwYb2H+pBF8gesqFxKGzCm4LVej1Al631ruqeakt9MMyn6jdZCN6jtQzXPLDVJyIlGliMLGusGwJKY/frJ7N8yfKuWXv0AUs9geEtLY1FdsLXVqC6RcH5hU/ZNs6rlm22ogATDaG6JnvmmSM6s0HKgdoFLyu6t4llXFHjoLX7cLiDtbofYAnwAOIC53TG0aymkb5sfZZD9q6mSAN3A4JivT0O6hZEp3V4wLxLdYuHaMUwHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qs/K+rtXV3H1G7OmRYYzm6Z+zZ3bqLmi/DvC0F/bNpU=;
 b=XCCyvoC7aXH/pm0tV60VX2lYp17q4gjFQ56K52turbiUBi1sySjwKkbj/1IS/MheCEP6XcxjHtvJA5c4Hr3FkbPx3wnLjWqsR/vVKfE1sKPNhWBVSQgUWfLUri6bXFaKpLblIZiRLMWUzeHXtxqYkcQOYcegTpbISvngNeaNGMY=
Authentication-Results: vmware.com; dkim=none (message not signed)
 header.d=none;vmware.com; dmarc=none action=none header.from=vmware.com;
Received: from BYAPR05MB5511.namprd05.prod.outlook.com (2603:10b6:a03:1a::28)
 by BYAPR05MB4709.namprd05.prod.outlook.com (2603:10b6:a03:4d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.10; Mon, 2 Nov
 2020 17:55:28 +0000
Received: from BYAPR05MB5511.namprd05.prod.outlook.com
 ([fe80::958b:64f6:b2f9:97e0]) by BYAPR05MB5511.namprd05.prod.outlook.com
 ([fe80::958b:64f6:b2f9:97e0%7]) with mapi id 15.20.3541.011; Mon, 2 Nov 2020
 17:55:28 +0000
Subject: Re: Re: Re: [PATCH for-rc] RDMA/vmw_pvrdma: Fix the active_speed and
 phys_state value
From:   Adit Ranadive <aditr@vmware.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org,
        pv-drivers@vmware.com
References: <20201028231945.6533-1-aditr@vmware.com>
 <20201029115733.GA2620339@nvidia.com>
 <e0a834a1-e5ee-4838-4718-d6ded1e954be@vmware.com>
Message-ID: <38f4a89a-c443-2cb2-a3de-89481a86e192@vmware.com>
Date:   Mon, 2 Nov 2020 09:55:25 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.0
In-Reply-To: <e0a834a1-e5ee-4838-4718-d6ded1e954be@vmware.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [107.3.164.70]
X-ClientProxiedBy: BY5PR03CA0006.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::16) To BYAPR05MB5511.namprd05.prod.outlook.com
 (2603:10b6:a03:1a::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from vmwin-005.intranet.hyperic.net (107.3.164.70) by BY5PR03CA0006.namprd03.prod.outlook.com (2603:10b6:a03:1e0::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend Transport; Mon, 2 Nov 2020 17:55:26 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fd83f6fb-baa2-4814-54c4-08d87f587af9
X-MS-TrafficTypeDiagnostic: BYAPR05MB4709:
X-LD-Processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR05MB4709C93B466D962D22FEA7DCC5100@BYAPR05MB4709.namprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:457;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /cXVNBBlj7biDxaGK+hXW8I0xDV5RhMWMf52y1Xf3w9fjivLYGppIQKIr59KCTUclo5hlZw8VQmLVydph8tD85SbYsIi8qT4BV3rIuGcDkZw6zZ10SkwaE6hT1x1yyVSrHcpLd3kdwMwJf72Qh/GVwxRu5A4fTsoceIfzr/6g5DX6cY46qDhBJAD0k/KgH00KwUi5YB4WSs4kqKwdtI809B64+1PaxIRF21AHPOjR13IetuSRihSAa0E8CFhq25ZhhT97hCCANa9qAcCp5k2YDqUfY9nUCG8MGfcNK7699dHwLGw+ROjcPtHPcuyZaMbl3wSmLdG19XfOfGIdMGetsut0DTLG9WfGDFuZqTKChW9YEzD9J1pLkQCBn4WIKc8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR05MB5511.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(366004)(376002)(39860400002)(396003)(66946007)(4326008)(6506007)(66556008)(66476007)(53546011)(5660300002)(8676002)(186003)(6512007)(16526019)(956004)(6486002)(31696002)(2616005)(316002)(26005)(478600001)(2906002)(8936002)(107886003)(83380400001)(6916009)(86362001)(36756003)(31686004)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: MVeZ1euQfx6v3GokuSN6Jhly/9/c+Kpwz7Pr8dg8TC9TEErqZ+vuN7rN4ebNt9sPZvNi5NE8nPzJt4xEylG3mLBazwSl0YVWk5QHeYTugGDlJInjqaJgh5ErPrTJ+TVwRd4SB9mcBFy1JxgR7dhdPjKCXKgwos3XxGl/5ZO2ssnVlLkP0OlnvNt2uVBq1Q+aHt5QCguqfzzUEUXOzwqhUjcKokvOSzR/wq+tDJCjIiVcbCZT0QzPjncXObQJyIOpeSoo05TMNJDaOPrEr+RbQ+2ZEEwiZdrv5YluHUZP6UsYgzm1nhjLLUs/9v9X+mvaAyP6SQwE27dJAX5/BsQjGmzKgeI8HOvbWx0iSTAKe+8nmgFkXom0EBtTl7mcqSdzQfXxGYywZ+s5TQAwcavJvhuk/mC6/lKvH9wLV+AbnAyslWzLzYQKSVKdbyu/sqKnbdo1rpIWiZn5ENmINEtSK3QPqsxcHip+TmkXeCc0tkEUdfWpQtnDCIz3KO80gCDaV6idrXHN7FxKgkboBLJ4+A2CP0FnpQ7XOdVthhj2cWj4bW5LTPq5wwnYCF31Yi2F5JsBpL4ZnA3ZE0v3vLdyxcg/j1duxNoUJgNp7LnoqxSwM+p3WS2mrJviqxL03IMcPLn0oVveSRvfliOtOjRIcA==
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd83f6fb-baa2-4814-54c4-08d87f587af9
X-MS-Exchange-CrossTenant-AuthSource: BYAPR05MB5511.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2020 17:55:28.4507
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uMK86HdmdETqgzso5j9TcfXWuLXC6zUb1bKyndb18/j1H6JCuVsfRFqQrZ63eFunlAtL3f7vIrw+kUJCzvXs2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB4709
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 10/29/20 9:16 AM, Adit Ranadive wrote:
> On 10/29/20 4:57 AM, Jason Gunthorpe wrote:
>> On Wed, Oct 28, 2020 at 11:19:45PM +0000, Adit Ranadive wrote:
>>> The PVRDMA device still reports the active_speed in u8.
>>> Lets use the ib_eth_get_speed to report the speed and
>>> width. Unfortunately, phys_state gets stored as msb of
>>> the new u16 active_speed.
>>
>> This explanation is not clear, I have no idea what this is fixing
> 
> It seemed more clear to me in my head, I guess :).
> 
> After commit 376ceb31ff87 changed the active_speed attribute to
> u16, both the active_speed and phys_state attributes in the
> pvrdma_port_attr struct are getting stored in this u16. As a 
> result, these show up as invalid values in ibv_devinfo.
> 
> Our device still gives us back a u8 active_speed so both these
> are getting stored in the u16. This fix I proposed simply gets 
> the active_speed from the netdev while the phys_state still 
> needs to come from the pvrdma device, i.e. the msb the of the
> u16. I also removed some unused functions as a result.
> 
> Alternatively, I could change the u8 active_width and u16 
> active_speed to reserved now that we're getting the active_speed
> and active_width from the ib_get_eth_speed function.
> 

Jason, did you have any comments on this or did you want me
to just send v1 with an updated description?

>>
>> Jason
>>
