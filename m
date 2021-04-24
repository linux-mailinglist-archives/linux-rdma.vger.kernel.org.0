Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91459369E84
	for <lists+linux-rdma@lfdr.de>; Sat, 24 Apr 2021 04:33:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232742AbhDXCd7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 23 Apr 2021 22:33:59 -0400
Received: from mail-co1nam11on2082.outbound.protection.outlook.com ([40.107.220.82]:4577
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232155AbhDXCd6 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 23 Apr 2021 22:33:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mVgkflp6gDTXVL+4np0j1mVnO6Xf3O2ddYYQziee6OBVw8qEq5dr47UFauybQ6FCRg1fZrPJJSd3thTb7noWU7uDgE9sMin92wj0YVrlGeUdfOa3oMm6b9vmg3hUEPkWBR+Mpt2CkXzZd1O5wIDB7ErXEgjw7sC7IT7FCWtieuPV2WJK4t/f8WKo3L3CLMnAkMA5G9SmTNqWEWtYGk52VGWo9ewddV2wagPK0PcV007MSCWram+Tx/atwJQ1+IoRjkJCMASxCHNQnwHfD3TskTbrZ6eo6ToklRg7GLX1fGWbEg0AIyRzNcXPv+SAEUWyrezYBgChL3sEqv431xLtkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g9gdVZRAnsjkhKeZjgqQB2D5y0YF2NnrtI3PYr/VWsw=;
 b=Ynxo0ruugg6CcNCalxiuZo6OI0RjLT762pGr6ltrEePj7tfeCLXrCFjN7FWhV/xjEEFkW10ZAUJRUcH+BjX+A0iOwcJCT1wcoKKyPS2fAP4FKDyULWlZgYXBOxSaLc1e1HhG5yNVTAizfVv1tvkO2U4VrPYLzDznY+KCEZq/pr2sGxKlpwJiwfdA9rS4jWcyueJD8NdfGMzWbi4N+euoMJqTLXDDKvMk8u38lYdiH5UE0YrjpQ3eW3KY4+bzQT+29uG8MHA/azbFAZ2flg4fRo4l5BhVjbdrKGP3vE5/6bD3yN94/k8+YMI5MjEqvGRuanvlE1ke9wzXMLLK+n43/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.32) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g9gdVZRAnsjkhKeZjgqQB2D5y0YF2NnrtI3PYr/VWsw=;
 b=GjVbzAbGFNt1pYdKoHvmHyY5YM6bb71pumiTwqMIP1Y/d4f2ipIeC0myWCrFO4yFJeiH1KqiWs2ZIGDgchgRTQqOi5hvDlA8D1hqj19YSN/MHdJuvMOwbP0rMp+SZZOEQlvFEj08N2XjVK0NgKO0FC/th5Csjnwh0XOxhM/V73TkTxWc+VBc+wVzMynFu2hpmjIOkEU268CDW+TzN955g28DrXD0QzaAvmHm8oGYprVW/r0S8uWVFi12iQuKvK6b7KBCV1WwZ7GRULFWes/vzUGt9c0GsKe5EBWBSvpHH+ivMD1msULFNlO5WmQ8IpjY13f0CGQj9YD8wdNDrX/Tlw==
Received: from MWHPR14CA0060.namprd14.prod.outlook.com (2603:10b6:300:81::22)
 by BL0PR12MB2339.namprd12.prod.outlook.com (2603:10b6:207:4e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21; Sat, 24 Apr
 2021 02:33:18 +0000
Received: from CO1NAM11FT049.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:81:cafe::ad) by MWHPR14CA0060.outlook.office365.com
 (2603:10b6:300:81::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20 via Frontend
 Transport; Sat, 24 Apr 2021 02:33:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.32)
 smtp.mailfrom=nvidia.com; redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.32 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.32; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.32) by
 CO1NAM11FT049.mail.protection.outlook.com (10.13.175.50) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4065.21 via Frontend Transport; Sat, 24 Apr 2021 02:33:18 +0000
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 23 Apr
 2021 19:33:17 -0700
Received: from [172.27.8.107] (172.20.145.6) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Sat, 24 Apr
 2021 02:33:16 +0000
Subject: Re: [PATCH rdma-next v2 7/9] IB/cm: Clear all associated AV's ports
 when remove a cm device
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        <linux-rdma@vger.kernel.org>
References: <cover.1619004798.git.leonro@nvidia.com>
 <00c97755c41b06af84f621a1b3e0e8adfe0771cc.1619004798.git.leonro@nvidia.com>
 <20210422193417.GA2435405@nvidia.com>
 <2eee42c7-04aa-eea1-f8a1-debf700ad0b0@nvidia.com>
 <20210423142430.GI1370958@nvidia.com>
From:   Mark Zhang <markzhang@nvidia.com>
Message-ID: <b14de504-52f8-14ac-f65c-bcdcd0eb1784@nvidia.com>
Date:   Sat, 24 Apr 2021 10:33:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210423142430.GI1370958@nvidia.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0a91e85e-7eb3-4b69-d16b-08d906c95233
X-MS-TrafficTypeDiagnostic: BL0PR12MB2339:
X-Microsoft-Antispam-PRVS: <BL0PR12MB23398420C39BBC093FA9F16EC7449@BL0PR12MB2339.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a0gmKwIrr1SbOM0mf90PhhNIIdvksa05+/O/XPhQZdakUIyVSDUEkel+By0Gi/HROnngu33OVL6uVF8YISsK40+y/Rd0KOz4f/rDN8CqpvvrhKHt4DvsI/7fwsjK5l8SbBdHyTCx0RacobIWBnSXZ2DpRURnz2ISIVI2NDNWOL464fpVK/HSBMIp8kYRse6KED/JE7x4exjAJG1BtpGytkA/pYeGBl4dIxv4gDNIg1FLz1Y2bfb90MU8qqeLSVZlLHYGUQCeshw5t3yOgHJujCYRqKCvZ2BG9qcIPjuImRLDjTvOK+fW4txw0ACg220hpgcYQj0itGYMsfAb1owwTs+pdfnkbkEB7KohZRigZzmjJezcKQONbHLxJz0pAnUi57+zV+nXMAEKbFI/L/4aK4V+zJataLxCvJKdthL9N3cn8wM9zbugEVPE+jznlp4DX8kvbfiLO+pRyVCMe+mAxQ00maC5mlowbFqb11fZFkJdUmW6fPAfPKC1mzS7tbKXnHm+obgLniiL0Hs5xN/ILBIIy4cwSBlS//48s2pNKPO6Oq3PZ+I7xY4YPPPpq2z6DDMJX3ebTAaXsgQamXCQOvlk5pPSKVbEJI9EFmIMDkhh4NCUnI8MB43FJdlPfXwTGPrbSbkSnjLQ9v3YbSbyJnqjLJsnzy0e4VEgkSk/UnYdTptsZz0J2LOwfN38zJ6S
X-Forefront-Antispam-Report: CIP:216.228.112.32;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid01.nvidia.com;CAT:NONE;SFS:(4636009)(136003)(396003)(346002)(376002)(39860400002)(36840700001)(46966006)(37006003)(16526019)(6862004)(2906002)(4326008)(26005)(8936002)(36756003)(36860700001)(426003)(47076005)(5660300002)(31696002)(2616005)(70206006)(16576012)(54906003)(70586007)(86362001)(31686004)(8676002)(478600001)(82310400003)(316002)(6636002)(7636003)(6666004)(186003)(53546011)(356005)(82740400003)(336012)(83380400001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2021 02:33:18.5897
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a91e85e-7eb3-4b69-d16b-08d906c95233
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.32];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT049.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2339
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 4/23/2021 10:24 PM, Jason Gunthorpe wrote:
> On Fri, Apr 23, 2021 at 09:14:21PM +0800, Mark Zhang wrote:
>>
>>
>> On 4/23/2021 3:34 AM, Jason Gunthorpe wrote:
>>> On Wed, Apr 21, 2021 at 02:40:37PM +0300, Leon Romanovsky wrote:
>>>> @@ -4396,6 +4439,14 @@ static void cm_remove_one(struct ib_device *ib_device, void *client_data)
>>>>    	cm_dev->going_down = 1;
>>>>    	spin_unlock_irq(&cm.lock);
>>>> +	list_for_each_entry_safe(cm_id_priv, tmp,
>>>> +				 &cm_dev->cm_id_priv_list, cm_dev_list) {
>>>> +		if (!list_empty(&cm_id_priv->cm_dev_list))
>>>> +			list_del(&cm_id_priv->cm_dev_list);
>>>> +		cm_id_priv->av.port = NULL;
>>>> +		cm_id_priv->alt_av.port = NULL;
>>>> +	}
>>>
>>> Ugh, this is in the wrong order, it has to be after the work queue
>>> flush..
>>>
>>> Hurm, I didn't see an easy way to fix it up, but I did think of a much
>>> better design!
>>>
>>> Generally speaking all we need is the memory of the cm_dev and port to
>>> remain active, we don't need to block or fence with cm_remove_one(),
>>> so just stick a memory kref on this thing and keep the memory. The
>>> only things that needs to seralize with cm_remove_one() are on the
>>> workqueue or take a spinlock (eg because they touch mad_agent)
>>>
>>> Try this, I didn't finish every detail, applies on top of your series,
>>> but you'll need to reflow it into new commits:
>>
>> Thanks Jason, I think we still need a rwlock to protect "av->port"? It is
>> modified and cleared by cm_set_av_port() and read in many places.
> 
> Hum..
> 
> This is a real mess.
> 
> It looks to me like any access to the av->port should always be
> protected by the cm_id_priv->lock
> 
> Most already are, but the sets are wrong and a couple readers are wrong
> 
> Set reverse call chains:
> 
> cm_init_av_for_lap()
>   cm_lap_handler(work) (ok)
> 
> cm_init_av_for_response()
>   cm_req_handler(work) (OK, cm_id_priv is on stack)
>   cm_sidr_req_handler(work) (OK, cm_id_priv is on stack)
> 
> cm_init_av_by_path()
>   cm_req_handler(work) (OK, cm_id_priv is on stack)
>   cm_lap_handler(work) (OK)
>   ib_send_cm_req() (not locked)
>     cma_connect_ib()
>      rdma_connect_locked()
>       [..]
>     ipoib_cm_send_req()
>     srp_send_req()
>       srp_connect_ch()
>        [..]
>   ib_send_cm_sidr_req() (not locked)
>    cma_resolve_ib_udp()
>     rdma_connect_locked()
> 

Both cm_init_av_for_lap() and cm_init_av_by_path() might sleep (the last 
patch of this series tries to fix this issue), they cannot be called 
with cm_id_priv->lock


> And
>    cm_destroy_id() (locked)
> 
> And read reverse call chains:
> 
> cm_alloc_msg()
>   ib_send_cm_req() (not locked)
>   ib_send_cm_rep() (OK)
>   ib_send_cm_rtu() (OK)
>   cm_send_dreq_locked() (OK)
>   cm_send_drep_locked() (OK)
>   cm_send_rej_locked() (OK)
>   ib_send_cm_mra() (OK)
>   ib_send_cm_sidr_req() (not locked)
>   cm_send_sidr_rep_locked() (OK)
> cm_form_tid()
>   cm_format_req()
>    ib_send_cm_req() (sort of OK)
>   cm_format_dreq()
>     cm_send_dreq_locked (OK)
> cm_format_req()
>    ib_send_cm_req() (sort of OK)
> cm_format_req_event()
>   cm_req_handler() (OK, cm_id_priv is on stack)
> cm_format_rep()
>   ib_send_cm_rep() (OK)
> cm_rep_handler(work) (OK)
> cm_establish_handler(work) (OK)
> cm_rtu_handler(work) (OK)
> cm_send_dreq_locked() (OK)
> cm_dreq_handler(work) (OK)
> cm_drep_handler(work) (OK)
> cm_rej_handler(work) (OK)
> cm_mra_handler(work) (OK)
> cm_apr_handler(work) (OK)
> cm_sidr_rep_handler(work) (OK)
> cm_init_qp_init_attr() (OK)
> cm_init_qp_rtr_attr() (OK)
> cm_init_qp_rts_attr() (OK)
> 
> So.. That leaves these functions that are not obviously locked
> correctly:
>   ib_send_cm_req()
>   ib_send_cm_sidr_req()
> 
> And the way their locking expects to work is basically because they
> expect that there are not parallel touches to the cm_id - however I'm
> doubtful this is completely true.
> 
> So no new lock needed, but something should be done about the above
> two functions, and this should be documented
> 
> Jason
> 
