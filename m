Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7C3C1CFF08
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2020 22:10:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725987AbgELUKo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 12 May 2020 16:10:44 -0400
Received: from mail-bn8nam12on2065.outbound.protection.outlook.com ([40.107.237.65]:13568
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725938AbgELUKn (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 12 May 2020 16:10:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K49w/9B7XJ+pTVeAE3Mc9871vJhv0YCbfoFfY9/4HU/XN2f0iarSGhXHE1uUNzMsd4K46OfOmLmq/dQSIY2d/+n0NlhTvem9+RqfDPSjZ/cob7CCbD1vhPQTZWBzWEyAJYVGt8wUg7LHlMWelvskXXTmwXCvgwm7tuCXeE9JR7JWhp6fWtG0zGllt124we6y5Y0LYwIsx/LfvWWsEp33kwg7lhZ2LLQF9Vkvckl8bOcMHy+u120IrWOh7sjz0kWu+YN6ThTNgL6YiOhVV8WeCwfAnuVCKsE3RfRQtB6kk/Vxqma+GiHbNKdA3JbeQK630hXzHauw3RVlsAjJQZTcXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g0Q0rrpOE1t9JoDfnn/jTrvkckqyydpiALX/VKer7rI=;
 b=Az/Kp7+rRIVN4kgElVpwhvLH1BMko37chcRmGCjd1L2/bn+EwRj9g01b4RaNDIUv6pFdNa9/yE87LthfERWT3NBsUML3XUhCwZMJRbRJo8l8yjDQ3Cm4dhCJsLj4ALpcv0X5UTLx+dkc/gXetMzOgBkZ6hPfZbcbjiO7vd9eWGhhr3zzCBb0MzHlN40PHIJaukOuX6nSDijdUDmXukiY5eKAmoPfjHLNh9OEjE2ZIOrM8jcgP6P1VdVBZZOQ4XbzsOjDYAzvAandHpz3OzcoPeHaYUN7jD6WTogOj4a7HjYXTPUTn0ytY+BC8CJsTUcmNov1++t572Kok0tL1v/6JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g0Q0rrpOE1t9JoDfnn/jTrvkckqyydpiALX/VKer7rI=;
 b=BZIvfw+jO1NTk19T9Q7YYmMgW170ORzRYwj9EstNkE5AMV+V/o7QhJYkPmwtaAfDd/06c5MUiovw/iM+FXnaAGO1CLCEavaLKfilQoLLjtvxhW0FeAimCB013rp9uk0HsmC94oRpbfHW35RvVbhUVtyicSKfvG/O5rkTQmDOhqA=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3560.namprd12.prod.outlook.com (2603:10b6:a03:ae::10)
 by BYAPR12MB3048.namprd12.prod.outlook.com (2603:10b6:a03:ad::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.34; Tue, 12 May
 2020 20:10:36 +0000
Received: from BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::fd29:4119:9ef5:8210]) by BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::fd29:4119:9ef5:8210%7]) with mapi id 15.20.2979.033; Tue, 12 May 2020
 20:10:36 +0000
Subject: Re: [RFC 16/17] drm/amdgpu: gpu recovery does full modesets
To:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Alex Deucher <alexdeucher@gmail.com>
Cc:     linux-rdma <linux-rdma@vger.kernel.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        linux-media <linux-media@vger.kernel.org>
References: <20200512085944.222637-1-daniel.vetter@ffwll.ch>
 <20200512085944.222637-17-daniel.vetter@ffwll.ch>
 <CADnq5_NJTwkUszd-F2d4D+kD4c_+FKD8tuhVJ7VWHGxAyd8fCg@mail.gmail.com>
 <20200512125841.GH206103@phenom.ffwll.local>
 <CADnq5_P3SQkH5D+a5bFBTu5eE2ws3O2wsNqnsP9rcvTQJP-nbA@mail.gmail.com>
 <CAKMK7uFh0MT_mWb4W5jB55D+twLk6k=Xk4f575Q=AR5fSdE3iQ@mail.gmail.com>
 <CADnq5_PR0fzab=U8KPSznDgw8twuKtgbBf3EGjoZB0UpyCorwg@mail.gmail.com>
 <CAKMK7uFZAedfE20orA3dGyxTuR3Q_d2yYBb6N3BSCCQvhunM4Q@mail.gmail.com>
 <CADnq5_PsjZP+s7VzAYX4k3aArGm=E7PQG21A0oo5Dxx1pPGabQ@mail.gmail.com>
 <CAKMK7uE+cvUUyiLqySDv0L=saW+fZCmArs3fqokuOV_pL8MGHQ@mail.gmail.com>
From:   "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>
Message-ID: <84ce83ba-0dc7-756a-c576-81c7319edfa0@amd.com>
Date:   Tue, 12 May 2020 16:10:32 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <CAKMK7uE+cvUUyiLqySDv0L=saW+fZCmArs3fqokuOV_pL8MGHQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT1PR01CA0070.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::9) To BYAPR12MB3560.namprd12.prod.outlook.com
 (2603:10b6:a03:ae::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.148.234] (165.204.55.211) by YT1PR01CA0070.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2d::9) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.28 via Frontend Transport; Tue, 12 May 2020 20:10:34 +0000
X-Originating-IP: [165.204.55.211]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d040c2f2-0771-4056-401e-08d7f6b08838
X-MS-TrafficTypeDiagnostic: BYAPR12MB3048:|BYAPR12MB3048:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB30480CB9E70D441F54396875ECBE0@BYAPR12MB3048.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 0401647B7F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3EBD8CEQpMms1hEsHsBEfY/6tSlHeGXkhQ8eNJjjOqiaH/n7ZAbEKvFJO0z2EBiuU5lh/XabJ6B/a+z6vAmtWQ0QdizJVRP0Fg+UDPV9QFgdFZ0IvIGTn56vopYL0oyMGAW04aQSs6CfXhFJZN5W4lK6f6oWRaAsPNznt7fpbw1MiauGkZ3ZLmq+p/PnXPqpt1mtIM5QGISDw9zeY7/C5HkI/394ob4cj1Ca2Z7DMuEBB78x/JKliJ2Rtbdv0As5KRGNKwxqi+LuB6axnMDqSMK7s79RJdjzG+RjwCEHCxiCe+7pXxYPGMRTVD9fUyWE3GYkKALqijyzcR6iZjFsqwjgFxE4YtovIXLAZqyyxJWRb5JPSLwQE4dalDNLaxmyocchdGyXrUA4EFdo2cJZkoO1UudMm8/+tI0u04dhAlN94FrPJi12mTmUQ6b+Pds3dQk3bxHyTaFnkZDcVUKnd9Xq1WzyIUCbcFGI18P7bB+x1fah+EidvW2iYQfhlG5U14gKoLwRQDzpefoz0S4PkGYds0ItZp+T4dVGwjpd/mhJo/z3trGPz0lGPSfSgQUdQ+NAsX9tQUOqS/hD3g56vBJ7ne3dnjczDwIWFGpr/zo/2TuFJYFfwpl0U43NPOcmE9eH7wC3jyQS2NLjWigNE0GkaqcTE4vVheaVhC2LFZ4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3560.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(396003)(39860400002)(376002)(346002)(136003)(33430700001)(956004)(66946007)(316002)(2616005)(966005)(54906003)(66556008)(110136005)(4326008)(66476007)(6486002)(86362001)(30864003)(2906002)(8936002)(478600001)(31686004)(16576012)(33440700001)(66574014)(7416002)(8676002)(52116002)(53546011)(16526019)(26005)(186003)(31696002)(5660300002)(83080400001)(36756003)(21314003)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: j+Go4Jff+0tkicgKhXoNFIFQrKe2nAhPddwPX1Aj28Nr1ihLIeLpAxTpDQ8bW1U6HeTrCe+PODIEcwxikYAkMsD1vFXd4LITyeII4B3Z+R+O2t1O1GiEEswmOYiF/Ound2VNxBT9x3C3jEj8sPZKJgLuOU2kOvaGTXG/rB3ISzTln9fmQSadrOsgPWDEE7ODJ0wOzWexCozNIjNQMqOZupQDZBDzoitNLtPAwLalzJkrLIT7IWPGivqpd9nJ+c9Tfm1Me8f4kWxpq3xunqCNkkoJg8QbQRu5Amk0Usu1H87wus31j3029vMwTvmQKlO6Vj4OQW6WRSwXAp4cHXvkkM4PcJ7n4yPsolyFC7ZnBpT9zDHChTUtTr4FZ/KGL2fPFLqW44bu/67sB6ymXiZHUcbSGNa3NRmq9KRYnZpADq0Z3wIXnGuwSlOGNeGs7cw2GqHMl5lWBAEOhghT54ypx7UsCr489yhvQOW9cUSGdpP2XoKziUdytsQTlvYnP/Or
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d040c2f2-0771-4056-401e-08d7f6b08838
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2020 20:10:36.0716
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7kvfXeZIbyA9UQZMAQaNBPab9SdBwc4YLcsxzn1t0+cRm2RJpvLfKbl6NhrRttvEDfCkvJ487MgwZ3wRXG/6Wg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3048
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2020-05-12 12:12 p.m., Daniel Vetter wrote:
> On Tue, May 12, 2020 at 4:24 PM Alex Deucher <alexdeucher@gmail.com> wrote:
>>
>> On Tue, May 12, 2020 at 9:45 AM Daniel Vetter <daniel.vetter@ffwll.ch> wrote:
>>>
>>> On Tue, May 12, 2020 at 3:29 PM Alex Deucher <alexdeucher@gmail.com> wrote:
>>>>
>>>> On Tue, May 12, 2020 at 9:17 AM Daniel Vetter <daniel.vetter@ffwll.ch> wrote:
>>>>>
>>>>> On Tue, May 12, 2020 at 3:12 PM Alex Deucher <alexdeucher@gmail.com> wrote:
>>>>>>
>>>>>> On Tue, May 12, 2020 at 8:58 AM Daniel Vetter <daniel@ffwll.ch> wrote:
>>>>>>>
>>>>>>> On Tue, May 12, 2020 at 08:54:45AM -0400, Alex Deucher wrote:
>>>>>>>> On Tue, May 12, 2020 at 5:00 AM Daniel Vetter <daniel.vetter@ffwll.ch> wrote:
>>>>>>>>>
>>>>>>>>> ...
>>>>>>>>>
>>>>>>>>> I think it's time to stop this little exercise.
>>>>>>>>>
>>>>>>>>> The lockdep splat, for the record:
>>>>>>>>>
>>>>>>>>> [  132.583381] ======================================================
>>>>>>>>> [  132.584091] WARNING: possible circular locking dependency detected
>>>>>>>>> [  132.584775] 5.7.0-rc3+ #346 Tainted: G        W
>>>>>>>>> [  132.585461] ------------------------------------------------------
>>>>>>>>> [  132.586184] kworker/2:3/865 is trying to acquire lock:
>>>>>>>>> [  132.586857] ffffc90000677c70 (crtc_ww_class_acquire){+.+.}-{0:0}, at: drm_atomic_helper_suspend+0x38/0x120 [drm_kms_helper]
>>>>>>>>> [  132.587569]
>>>>>>>>>                 but task is already holding lock:
>>>>>>>>> [  132.589044] ffffffff82318c80 (dma_fence_map){++++}-{0:0}, at: drm_sched_job_timedout+0x25/0xf0 [gpu_sched]
>>>>>>>>> [  132.589803]
>>>>>>>>>                 which lock already depends on the new lock.
>>>>>>>>>
>>>>>>>>> [  132.592009]
>>>>>>>>>                 the existing dependency chain (in reverse order) is:
>>>>>>>>> [  132.593507]
>>>>>>>>>                 -> #2 (dma_fence_map){++++}-{0:0}:
>>>>>>>>> [  132.595019]        dma_fence_begin_signalling+0x50/0x60
>>>>>>>>> [  132.595767]        drm_atomic_helper_commit+0xa1/0x180 [drm_kms_helper]
>>>>>>>>> [  132.596567]        drm_client_modeset_commit_atomic+0x1ea/0x250 [drm]
>>>>>>>>> [  132.597420]        drm_client_modeset_commit_locked+0x55/0x190 [drm]
>>>>>>>>> [  132.598178]        drm_client_modeset_commit+0x24/0x40 [drm]
>>>>>>>>> [  132.598948]        drm_fb_helper_restore_fbdev_mode_unlocked+0x4b/0xa0 [drm_kms_helper]
>>>>>>>>> [  132.599738]        drm_fb_helper_set_par+0x30/0x40 [drm_kms_helper]
>>>>>>>>> [  132.600539]        fbcon_init+0x2e8/0x660
>>>>>>>>> [  132.601344]        visual_init+0xce/0x130
>>>>>>>>> [  132.602156]        do_bind_con_driver+0x1bc/0x2b0
>>>>>>>>> [  132.602970]        do_take_over_console+0x115/0x180
>>>>>>>>> [  132.603763]        do_fbcon_takeover+0x58/0xb0
>>>>>>>>> [  132.604564]        register_framebuffer+0x1ee/0x300
>>>>>>>>> [  132.605369]        __drm_fb_helper_initial_config_and_unlock+0x36e/0x520 [drm_kms_helper]
>>>>>>>>> [  132.606187]        amdgpu_fbdev_init+0xb3/0xf0 [amdgpu]
>>>>>>>>> [  132.607032]        amdgpu_device_init.cold+0xe90/0x1677 [amdgpu]
>>>>>>>>> [  132.607862]        amdgpu_driver_load_kms+0x5a/0x200 [amdgpu]
>>>>>>>>> [  132.608697]        amdgpu_pci_probe+0xf7/0x180 [amdgpu]
>>>>>>>>> [  132.609511]        local_pci_probe+0x42/0x80
>>>>>>>>> [  132.610324]        pci_device_probe+0x104/0x1a0
>>>>>>>>> [  132.611130]        really_probe+0x147/0x3c0
>>>>>>>>> [  132.611939]        driver_probe_device+0xb6/0x100
>>>>>>>>> [  132.612766]        device_driver_attach+0x53/0x60
>>>>>>>>> [  132.613593]        __driver_attach+0x8c/0x150
>>>>>>>>> [  132.614419]        bus_for_each_dev+0x7b/0xc0
>>>>>>>>> [  132.615249]        bus_add_driver+0x14c/0x1f0
>>>>>>>>> [  132.616071]        driver_register+0x6c/0xc0
>>>>>>>>> [  132.616902]        do_one_initcall+0x5d/0x2f0
>>>>>>>>> [  132.617731]        do_init_module+0x5c/0x230
>>>>>>>>> [  132.618560]        load_module+0x2981/0x2bc0
>>>>>>>>> [  132.619391]        __do_sys_finit_module+0xaa/0x110
>>>>>>>>> [  132.620228]        do_syscall_64+0x5a/0x250
>>>>>>>>> [  132.621064]        entry_SYSCALL_64_after_hwframe+0x49/0xb3
>>>>>>>>> [  132.621903]
>>>>>>>>>                 -> #1 (crtc_ww_class_mutex){+.+.}-{3:3}:
>>>>>>>>> [  132.623587]        __ww_mutex_lock.constprop.0+0xcc/0x10c0
>>>>>>>>> [  132.624448]        ww_mutex_lock+0x43/0xb0
>>>>>>>>> [  132.625315]        drm_modeset_lock+0x44/0x120 [drm]
>>>>>>>>> [  132.626184]        drmm_mode_config_init+0x2db/0x8b0 [drm]
>>>>>>>>> [  132.627098]        amdgpu_device_init.cold+0xbd1/0x1677 [amdgpu]
>>>>>>>>> [  132.628007]        amdgpu_driver_load_kms+0x5a/0x200 [amdgpu]
>>>>>>>>> [  132.628920]        amdgpu_pci_probe+0xf7/0x180 [amdgpu]
>>>>>>>>> [  132.629804]        local_pci_probe+0x42/0x80
>>>>>>>>> [  132.630690]        pci_device_probe+0x104/0x1a0
>>>>>>>>> [  132.631583]        really_probe+0x147/0x3c0
>>>>>>>>> [  132.632479]        driver_probe_device+0xb6/0x100
>>>>>>>>> [  132.633379]        device_driver_attach+0x53/0x60
>>>>>>>>> [  132.634275]        __driver_attach+0x8c/0x150
>>>>>>>>> [  132.635170]        bus_for_each_dev+0x7b/0xc0
>>>>>>>>> [  132.636069]        bus_add_driver+0x14c/0x1f0
>>>>>>>>> [  132.636974]        driver_register+0x6c/0xc0
>>>>>>>>> [  132.637870]        do_one_initcall+0x5d/0x2f0
>>>>>>>>> [  132.638765]        do_init_module+0x5c/0x230
>>>>>>>>> [  132.639654]        load_module+0x2981/0x2bc0
>>>>>>>>> [  132.640522]        __do_sys_finit_module+0xaa/0x110
>>>>>>>>> [  132.641372]        do_syscall_64+0x5a/0x250
>>>>>>>>> [  132.642203]        entry_SYSCALL_64_after_hwframe+0x49/0xb3
>>>>>>>>> [  132.643022]
>>>>>>>>>                 -> #0 (crtc_ww_class_acquire){+.+.}-{0:0}:
>>>>>>>>> [  132.644643]        __lock_acquire+0x1241/0x23f0
>>>>>>>>> [  132.645469]        lock_acquire+0xad/0x370
>>>>>>>>> [  132.646274]        drm_modeset_acquire_init+0xd2/0x100 [drm]
>>>>>>>>> [  132.647071]        drm_atomic_helper_suspend+0x38/0x120 [drm_kms_helper]
>>>>>>>>> [  132.647902]        dm_suspend+0x1c/0x60 [amdgpu]
>>>>>>>>> [  132.648698]        amdgpu_device_ip_suspend_phase1+0x83/0xe0 [amdgpu]
>>>>>>>>> [  132.649498]        amdgpu_device_ip_suspend+0x1c/0x60 [amdgpu]
>>>>>>>>> [  132.650300]        amdgpu_device_gpu_recover.cold+0x4e6/0xe64 [amdgpu]
>>>>>>>>> [  132.651084]        amdgpu_job_timedout+0xfb/0x150 [amdgpu]
>>>>>>>>> [  132.651825]        drm_sched_job_timedout+0x8a/0xf0 [gpu_sched]
>>>>>>>>> [  132.652594]        process_one_work+0x23c/0x580
>>>>>>>>> [  132.653402]        worker_thread+0x50/0x3b0
>>>>>>>>> [  132.654139]        kthread+0x12e/0x150
>>>>>>>>> [  132.654868]        ret_from_fork+0x27/0x50
>>>>>>>>> [  132.655598]
>>>>>>>>>                 other info that might help us debug this:
>>>>>>>>>
>>>>>>>>> [  132.657739] Chain exists of:
>>>>>>>>>                   crtc_ww_class_acquire --> crtc_ww_class_mutex --> dma_fence_map
>>>>>>>>>
>>>>>>>>> [  132.659877]  Possible unsafe locking scenario:
>>>>>>>>>
>>>>>>>>> [  132.661416]        CPU0                    CPU1
>>>>>>>>> [  132.662126]        ----                    ----
>>>>>>>>> [  132.662847]   lock(dma_fence_map);
>>>>>>>>> [  132.663574]                                lock(crtc_ww_class_mutex);
>>>>>>>>> [  132.664319]                                lock(dma_fence_map);
>>>>>>>>> [  132.665063]   lock(crtc_ww_class_acquire);
>>>>>>>>> [  132.665799]
>>>>>>>>>                  *** DEADLOCK ***
>>>>>>>>>
>>>>>>>>> [  132.667965] 4 locks held by kworker/2:3/865:
>>>>>>>>> [  132.668701]  #0: ffff8887fb81c938 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work+0x1bc/0x580
>>>>>>>>> [  132.669462]  #1: ffffc90000677e58 ((work_completion)(&(&sched->work_tdr)->work)){+.+.}-{0:0}, at: process_one_work+0x1bc/0x580
>>>>>>>>> [  132.670242]  #2: ffffffff82318c80 (dma_fence_map){++++}-{0:0}, at: drm_sched_job_timedout+0x25/0xf0 [gpu_sched]
>>>>>>>>> [  132.671039]  #3: ffff8887b84a1748 (&adev->lock_reset){+.+.}-{3:3}, at: amdgpu_device_gpu_recover.cold+0x59e/0xe64 [amdgpu]
>>>>>>>>> [  132.671902]
>>>>>>>>>                 stack backtrace:
>>>>>>>>> [  132.673515] CPU: 2 PID: 865 Comm: kworker/2:3 Tainted: G        W         5.7.0-rc3+ #346
>>>>>>>>> [  132.674347] Hardware name: System manufacturer System Product Name/PRIME X370-PRO, BIOS 4011 04/19/2018
>>>>>>>>> [  132.675194] Workqueue: events drm_sched_job_timedout [gpu_sched]
>>>>>>>>> [  132.676046] Call Trace:
>>>>>>>>> [  132.676897]  dump_stack+0x8f/0xd0
>>>>>>>>> [  132.677748]  check_noncircular+0x162/0x180
>>>>>>>>> [  132.678604]  ? stack_trace_save+0x4b/0x70
>>>>>>>>> [  132.679459]  __lock_acquire+0x1241/0x23f0
>>>>>>>>> [  132.680311]  lock_acquire+0xad/0x370
>>>>>>>>> [  132.681163]  ? drm_atomic_helper_suspend+0x38/0x120 [drm_kms_helper]
>>>>>>>>> [  132.682021]  ? cpumask_next+0x16/0x20
>>>>>>>>> [  132.682880]  ? module_assert_mutex_or_preempt+0x14/0x40
>>>>>>>>> [  132.683737]  ? __module_address+0x28/0xf0
>>>>>>>>> [  132.684601]  drm_modeset_acquire_init+0xd2/0x100 [drm]
>>>>>>>>> [  132.685466]  ? drm_atomic_helper_suspend+0x38/0x120 [drm_kms_helper]
>>>>>>>>> [  132.686335]  drm_atomic_helper_suspend+0x38/0x120 [drm_kms_helper]
>>>>>>>>> [  132.687255]  dm_suspend+0x1c/0x60 [amdgpu]
>>>>>>>>> [  132.688152]  amdgpu_device_ip_suspend_phase1+0x83/0xe0 [amdgpu]
>>>>>>>>> [  132.689057]  ? amdgpu_fence_process+0x4c/0x150 [amdgpu]
>>>>>>>>> [  132.689963]  amdgpu_device_ip_suspend+0x1c/0x60 [amdgpu]
>>>>>>>>> [  132.690893]  amdgpu_device_gpu_recover.cold+0x4e6/0xe64 [amdgpu]
>>>>>>>>> [  132.691818]  amdgpu_job_timedout+0xfb/0x150 [amdgpu]
>>>>>>>>> [  132.692707]  drm_sched_job_timedout+0x8a/0xf0 [gpu_sched]
>>>>>>>>> [  132.693597]  process_one_work+0x23c/0x580
>>>>>>>>> [  132.694487]  worker_thread+0x50/0x3b0
>>>>>>>>> [  132.695373]  ? process_one_work+0x580/0x580
>>>>>>>>> [  132.696264]  kthread+0x12e/0x150
>>>>>>>>> [  132.697154]  ? kthread_create_worker_on_cpu+0x70/0x70
>>>>>>>>> [  132.698057]  ret_from_fork+0x27/0x50
>>>>>>>>>
>>>>>>>>> Cc: linux-media@vger.kernel.org
>>>>>>>>> Cc: linaro-mm-sig@lists.linaro.org
>>>>>>>>> Cc: linux-rdma@vger.kernel.org
>>>>>>>>> Cc: amd-gfx@lists.freedesktop.org
>>>>>>>>> Cc: intel-gfx@lists.freedesktop.org
>>>>>>>>> Cc: Chris Wilson <chris@chris-wilson.co.uk>
>>>>>>>>> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
>>>>>>>>> Cc: Christian König <christian.koenig@amd.com>
>>>>>>>>> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
>>>>>>>>> ---
>>>>>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 8 ++++++++
>>>>>>>>>   1 file changed, 8 insertions(+)
>>>>>>>>>
>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>>>>> index 3584e29323c0..b3b84a0d3baf 100644
>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>>>>> @@ -2415,6 +2415,14 @@ static int amdgpu_device_ip_suspend_phase1(struct amdgpu_device *adev)
>>>>>>>>>                  /* displays are handled separately */
>>>>>>>>>                  if (adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_DCE) {
>>>>>>>>>                          /* XXX handle errors */
>>>>>>>>> +
>>>>>>>>> +                       /*
>>>>>>>>> +                        * This is dm_suspend, which calls modeset locks, and
>>>>>>>>> +                        * that a pretty good inversion against dma_fence_signal
>>>>>>>>> +                        * which gpu recovery is supposed to guarantee.
>>>>>>>>> +                        *
>>>>>>>>> +                        * Dont ask me how to fix this.
>>>>>>>>> +                        */
>>>>>>>>
>>>>>>>> We actually have a fix for this.  Will be out shortly.
>>>>>>>
>>>>>>> Spoilers? Solid way is to sidesteck the entire thing by avoiding to reset
>>>>>>> the display block entirely. Fixing the locking while still resetting the
>>>>>>> display is going to be really hard otoh ...
>>>>>>
>>>>>> There's no way to avoid that.  On dGPUs at least a full asic reset is
>>>>>> a full asic reset.  Mostly just skips the modeset and does the minimum
>>>>>> amount necessary to get the display block into a good state for reset.
>>>>>
>>>>> But how do you restore the display afterwards? "[RFC 13/17]
>>>>> drm/scheduler: use dma-fence annotations in tdr work" earlier in the
>>>>> series has some ideas from me for at least
>>>>> some of the problems for tdr when the display gets reset along.
>>>>> Whacking the display while a modeset/flip/whatever is ongoing
>>>>> concurrently doesn't sound like a good idea, so not sure how you can
>>>>> do that without taking the drm_modeset_locks. And once you do that,
>>>>> it's deadlock time.
>>>>
>>>> We cache the current display hw state and restore it after the reset
>>>> without going through the atomic interfaces so everything is back the
>>>> way it was before the reset.
>>>
>>> Hm this sounds interesting ... how do you make sure a concurrent
>>> atomic update doesn't trample over the same mmio registers while you
>>> do that dance?
>>
>> We take the dm->dc_lock across the reset.
> 
> Ok if that's an innermost lock and you don't do any dma_fence_wait()
> while holding that (or anything that somehow depends upon that again)
> I think that should work. From a quick look at current code in
> drm-next that seems to be the case. But would be good to check with my
> annotations whether everything is placed correctly (or maybe there's a
> bug in my annotations).
> 
> I still think something like I described in the drm/scheduler patch,
> which would allow us to take drm_modeset_locks in tdr path, would be a
> cleaner and more robust solution longer term. Forcing drivers to do
> their own modeset state looking just doesn't feel that awesome ... I
> guess that also depends upon how many other drivers have this problem.
> 

I worked a bit on analyzing the original problem faced here with using 
our regular dm_suspend/dm_resume here for GPU reset and I'm not sure how 
taking the drm_modeset_locks really buys us anything.

We ran into a deadlock caused by an async pageflip commit coming in 
along with the TDR suspend commit and the async commit wanted the 
dma_fence associated with the plane. The tdr commit suspend commit then 
started waiting for the pageflip commit to finish - which never happens 
since the fence hasn't been signaled yet and DRM spins forever.

If the dma_fence is "force" signaled in suspend then the async commit 
continues and the suspend commit follows after as normal. The async 
commit no longer holds any of the DRM locks because atomic_commit has 
already finished - we had no trouble grabbing the locks for the tdr commit.

Force signaling the fence wasn't really an option for solving this issue 
though, and DRM doesn't support aborting atomic commits nor would most 
drivers be well equipped to handle this I think - it's no longer really 
atomic at that point.

Ideally we don't actually have that pageflip commit programmed during 
the TDR since we'll have to reapply that same state again after, so what 
we're stuck with is the solution that we're planning on putting into 
driver - hold the internal driver locks across the suspend/reset so 
there's no way for the pageflip commit to start processing after having 
its fence signaled.

We're essentially just faking that the state is the exact same as it was 
before the GPU reset process started.

I'm open to suggestions or improvements for handling this but the 
easiest solution seemed to just bypass the entire DRM stack under the hood.

Regards,
Nicholas Kazlauskas

>>>> IIRC, when we reset the reset of the
>>>> GPU, we disconnect the fences, and then re-attach them after a reset.
>>>
>>> Where is that code? Since I'm not sure how you can make that work
>>> without getting stuck in another kind of deadlock in tdr. But maybe
>>> the code has some clever trick to pull that off somehow.
>>
>> The GPU scheduler.  drm_sched_stop, drm_sched_resubmit_jobs, and
>> drm_sched_start.
> 
> That seems to just be about the scheduler-internal fences. That
> tracking you kinda have to throw away and restart with a reset. But I
> don't think these are the fences visible to other places, like in
> dma_resv or drm_syncobj or wherever.
> -Daniel
> 
>> Alex
>>
>>
>>> -Daniel
>>>
>>>>
>>>> Alex
>>>>
>>>>> -Daniel
>>>>> --
>>>>> Daniel Vetter
>>>>> Software Engineer, Intel Corporation
>>>>> +41 (0) 79 365 57 48 - http://blog.ffwll.ch/
>>>
>>>
>>>
>>> --
>>> Daniel Vetter
>>> Software Engineer, Intel Corporation
>>> +41 (0) 79 365 57 48 - http://blog.ffwll.ch/
> 
> 
> 

