Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 365622A32C8
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Nov 2020 19:21:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725805AbgKBSVb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 2 Nov 2020 13:21:31 -0500
Received: from mail-bn8nam11on2061.outbound.protection.outlook.com ([40.107.236.61]:38656
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725797AbgKBSVa (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 2 Nov 2020 13:21:30 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uj6T4ARzpVWIX7MxniSfewV0jgdMg+usWh6YSY2S5MHy4QN26VvbQugq+fdfTGMkXs1KENScavBoEqogXk+5/IkiHnKgTozr4xY5bNqZPLpMw3FO6OizCy7C0Xj832HnorhyfFrT7VlwmfYiHJ8UXDRtvxvzTVOsVsltcFYG7ccpJ4OosPVAEFKQ5JJJF4BaiAloUT7agqQ5WUbkXPp073kA6NSKZHclnEwZO3F+ZJYHgmraXFj9rsbnl+VZ90cAhgf8eozrFWQvBVoL26+lbTResDSf5DJtUyi52TJTcrNZvUc9C3UeNcACQsQIWQ5WOc8qAQ88bVqOnm3VA4tDog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y8uCfwBMiEL8Z6wJ1yf5yrFMk9cLjiabxevdva+B7hQ=;
 b=e7qxBc/qT8i9UClMwd+08d2NinbEkcKszo6b/EaF3S1dXvfL1FEfleZFk79Ev4xbZEUE9fSADi4DQYu0kpKIi+1fhAcreODS7mb6+zAfQdSXG6h2bivBpAUwi4qszvXKZ9bNBEePMT8hmXg344/zyF+ON2VSv+rAF7MEhCY8mts3lSszqoJO8yWoxhEX2ruAIvvA/uq9c+/PbCpnhLhE5HeDBzzsTGn2W6VLQKfoQU6osZKZn0uvczbOyXvMa4QIuqCheyVBhqHtBVB7Ntm6D/QJACyfMea5sLSJl4BkOHKXam1BPLw5GbQS5KU92ylZklQIf63dEkuZ3QpKnEKY+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y8uCfwBMiEL8Z6wJ1yf5yrFMk9cLjiabxevdva+B7hQ=;
 b=FGc3aKbNIfyzig2GWYDCUMbd6Oy6do9cd6hjQclrmSuPhZuiL/oQVKaJuVpUZJhub6HtI5kl9fymPr8EHEXnWVgMNXwa7+Zj/+SXpgWjGwylgK37udbCyWxmoOk+fN9N1/t8bzbE/b0GGqIT6DCsUyAAUsLr+vXAPwmFxmAFQWw=
Authentication-Results: vmware.com; dkim=none (message not signed)
 header.d=none;vmware.com; dmarc=none action=none header.from=vmware.com;
Received: from BYAPR05MB5511.namprd05.prod.outlook.com (2603:10b6:a03:1a::28)
 by BYAPR05MB4775.namprd05.prod.outlook.com (2603:10b6:a03:43::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.10; Mon, 2 Nov
 2020 18:21:23 +0000
Received: from BYAPR05MB5511.namprd05.prod.outlook.com
 ([fe80::958b:64f6:b2f9:97e0]) by BYAPR05MB5511.namprd05.prod.outlook.com
 ([fe80::958b:64f6:b2f9:97e0%7]) with mapi id 15.20.3541.011; Mon, 2 Nov 2020
 18:21:23 +0000
Subject: Re: [PATCH for-rc] RDMA/vmw_pvrdma: Fix the active_speed and
 phys_state value
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org,
        pv-drivers@vmware.com
References: <20201028231945.6533-1-aditr@vmware.com>
 <20201029115733.GA2620339@nvidia.com>
 <e0a834a1-e5ee-4838-4718-d6ded1e954be@vmware.com>
 <38f4a89a-c443-2cb2-a3de-89481a86e192@vmware.com>
 <20201102180256.GG2620339@nvidia.com>
From:   Adit Ranadive <aditr@vmware.com>
Message-ID: <f8b16c37-14ef-5663-048c-75def55968b1@vmware.com>
Date:   Mon, 2 Nov 2020 10:21:21 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.0
In-Reply-To: <20201102180256.GG2620339@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [107.3.164.70]
X-ClientProxiedBy: BYAPR05CA0024.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::37) To BYAPR05MB5511.namprd05.prod.outlook.com
 (2603:10b6:a03:1a::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from vmwin-005.intranet.hyperic.net (107.3.164.70) by BYAPR05CA0024.namprd05.prod.outlook.com (2603:10b6:a03:c0::37) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.10 via Frontend Transport; Mon, 2 Nov 2020 18:21:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 33619f10-17d6-4a12-db1a-08d87f5c1a2c
X-MS-TrafficTypeDiagnostic: BYAPR05MB4775:
X-LD-Processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR05MB4775184391FBD8A54B0142C3C5100@BYAPR05MB4775.namprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:785;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lzur6+hBGd8RGdgoXgNqhVlimsEDOZMxYHsLOCb6dPQKJXUjrJONG+DmVX0Bu86soLZF6lzNKdl6/dPmsmJug5I94VUGwK6FGUM0VYspQ1c2roPgpqdTvEn9+q+lTyVDByGZbF/D4ImFhQa1NjQPF3liJKCZ38Ar6cf/nXgT3LZQCn45RlLrXfK5OTSedob6M4n0wgreFyXfR3s/lWN9JQeSqcnhwLRq5AD0GkB4Z+MEEbM/JfXcudJoeZWuD5hjQ6K9y4kp02sBnbFnrdj4mdDX1ncwNX83tLCK5Bz/42Qnsn5vVSYCFnl0jTIOmUjv+A+GQUVNYT1WLoCDXenhYz1FO3EmuOzqDyJvCDRsXYQ7vgXfUyI4sj0YYgabjZ8O
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR05MB5511.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(346002)(39860400002)(366004)(396003)(316002)(86362001)(31696002)(26005)(6506007)(8936002)(53546011)(83380400001)(6512007)(16526019)(186003)(8676002)(6486002)(36756003)(31686004)(6916009)(107886003)(66556008)(66946007)(66476007)(478600001)(4326008)(2616005)(956004)(2906002)(5660300002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: AF0u6kMh7fCO92mPqVNoDWL6yiDBpJO8wLNfaS+FXUIh+gGNZw4V4yvDPWsLwywJ8s3uYGmLyV7crJ8ir8LX2W7bPzNBkTUebP6Rlx90yKDC5n0h5TptD4yuf6at3WQi8zTgNFPcPYhmzkvA/FdC+Nu0v26AmA8XVJMDK+U7Tu8rN5xR3QuuPh6ODL4n1rbubG9+AjZIPETPL+z5SHnufYb85mvVhHfmnyEDKoBaan4gdkMSbUqLauXPaqO4FHM1LoA+Zoeq0+CoMMpad1iEF1v/Hnsz6alLqEOYWVP5pcdZ+lyBjg4ENygaDNaf2+MGt+smn+lhqbPCO3KFDHZcEJAm0+by6HG8hWtmvNUlfauWRPzN08UcSpJSs6h47+5iOI3YeFpZB9idvajquGB+5vvXADzpoopuJvbRQzBcYRSozHjTqiryRhFwXt1RCInkn0wMJvhRXvre9RfVMT+xRJli76YlDuiRZ0izP6Ii/GrmQpjmuRlsBnjICNDjQZc4siv8CXwECWdwPamWXM+sUuTJm2PmkPMkea5iqR9KkoQHMDDrFh4bAnOAIwMtvzza+AXx2aOylqMRiFP28hA7cQjVNv7APURyjwiYwghdkEdF8L8wYHHozMz3UrP/4LadWwx6saJ9Ovmcf1T3QBCd7A==
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33619f10-17d6-4a12-db1a-08d87f5c1a2c
X-MS-Exchange-CrossTenant-AuthSource: BYAPR05MB5511.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2020 18:21:23.6394
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2qnvqlPuMqL4HFEcX3TQ6nRgRDbFP4rIUSK0OSe6uAcUP1npM3UpbX0NER6hi1zpGIDwxJDV5OvbhmXS0UUP4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB4775
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 11/2/20 10:02 AM, Jason Gunthorpe wrote:
> On Mon, Nov 02, 2020 at 09:55:25AM -0800, Adit Ranadive wrote:
>> On 10/29/20 9:16 AM, Adit Ranadive wrote:
>>> On 10/29/20 4:57 AM, Jason Gunthorpe wrote:
>>>> On Wed, Oct 28, 2020 at 11:19:45PM +0000, Adit Ranadive wrote:
>>>>> The PVRDMA device still reports the active_speed in u8.
>>>>> Lets use the ib_eth_get_speed to report the speed and
>>>>> width. Unfortunately, phys_state gets stored as msb of
>>>>> the new u16 active_speed.
>>>>
>>>> This explanation is not clear, I have no idea what this is fixing
>>>
>>> It seemed more clear to me in my head, I guess :).
>>>
>>> After commit 376ceb31ff87 changed the active_speed attribute to
>>> u16, both the active_speed and phys_state attributes in the
>>> pvrdma_port_attr struct are getting stored in this u16. As a 
>>> result, these show up as invalid values in ibv_devinfo.
>>>
>>> Our device still gives us back a u8 active_speed so both these
>>> are getting stored in the u16. This fix I proposed simply gets 
>>> the active_speed from the netdev while the phys_state still 
>>> needs to come from the pvrdma device, i.e. the msb the of the
>>> u16. I also removed some unused functions as a result.
>>>
>>> Alternatively, I could change the u8 active_width and u16 
>>> active_speed to reserved now that we're getting the active_speed
>>> and active_width from the ib_get_eth_speed function.
>>
>> Jason, did you have any comments on this or did you want me
>> to just send v1 with an updated description?
> 
> I still haven't figured out what this is fixing.
> 
> Is 'struct pvrdma_port_attr' some kind of ABI? If so why isn't the fix
> to revert the type?

I can revert it but I thought that it had to a u16 based on the IBTA, no?
Or does that not apply to device-level stuff?
Also, instead of reverting it seemed better to use the ib_get_eth_speed
function to get the active_speed based on the netdev.
