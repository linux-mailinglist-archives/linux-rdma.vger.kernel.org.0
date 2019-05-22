Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ECE0D263FA
	for <lists+linux-rdma@lfdr.de>; Wed, 22 May 2019 14:42:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728703AbfEVMmz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 22 May 2019 08:42:55 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54372 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728468AbfEVMmz (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 22 May 2019 08:42:55 -0400
Received: by mail-wm1-f68.google.com with SMTP id i3so2078592wml.4
        for <linux-rdma@vger.kernel.org>; Wed, 22 May 2019 05:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=0qd+hUvOTrq+ndzW/yU4KM/dAPUNhCJDluPyXOCzcS4=;
        b=O1tcA4aX8v6Dsk9GldvM2j2XlUn1pRswzAnZQi5qDI5TGm6KvpzWMZtV5SOjrwbFGz
         QvRZvImrOrx1RGK7UPMpd5uJgQ4Ndyu0BXWejasZ+Gi6y1D0hu+eVBUirkWKQHg1ygbn
         g2s7NF3dFmuqycS9Ai3xZB4D8ufPsN6xwZD4wdWoyC452EKKx19hYcNpq04flPRCiDGM
         RVyMZRn5dcGN00ZELE9NIT+sJBZH2YyoiTCllSkhluqqXnQ63k6e+XZv9hdB4goXxa5C
         KVxyrwy+S4D9tha27jl7CNRIew75UG8sqMHkXrLq270+Pffzt9YM2JwxpRnUcvHdHZop
         /i0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=0qd+hUvOTrq+ndzW/yU4KM/dAPUNhCJDluPyXOCzcS4=;
        b=rDcy8XnG6FY6Y094oiyJEyOJvj6CVBkrFhPWkUvxAxIJsagSjZGc3dEY0TeQkkwaFi
         C5DMX0jsJNE/U1VHHPGllw6fFLMZv/QvEGA0bNdTqt087Ay/SgEnDJPRqpoiNaxOCD08
         Q3FmGhR6WoFd+b1zH2nwPY0jaIRQx2H5344nX6jv14uNF1kMIdQtahta1AU9B8cqjSN5
         KscfIo5S8r9+27w3wxqpLl9D6r6n2720dNfWtwUW254O9HeLuzZhQCmCw6+d+165xn0a
         KeqhgIiLpiAxo81UUImmYOywh64XShC+roFCB/4A4FOpvuPAn7sHG/8lp9q+O68YThCT
         ffdQ==
X-Gm-Message-State: APjAAAUF1WFFvWxk1LZtRY/Ibu5U8+yE8934SN/tbd3Wa3oIl4kPq3AZ
        SZ/V4zeDTtc/b8Dw1mAoP5Q=
X-Google-Smtp-Source: APXvYqww315j8VoBlB22+1ab4OVulwdOK9AFT2CJSQyYNnYyTiShOxnzMbHVy1pKSpUjJG/8eTZvbw==
X-Received: by 2002:a1c:20d7:: with SMTP id g206mr7246729wmg.136.1558528971906;
        Wed, 22 May 2019 05:42:51 -0700 (PDT)
Received: from kheib-workstation (bzq-79-181-8-139.red.bezeqint.net. [79.181.8.139])
        by smtp.gmail.com with ESMTPSA id 91sm37908066wrs.43.2019.05.22.05.42.49
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 22 May 2019 05:42:51 -0700 (PDT)
Message-ID: <970f7a5caea09680b8bd7861ce43782fc34c127d.camel@gmail.com>
Subject: Re: [PATCH for-next] RDMA/core: Avoid panic when port_data isn't
 initialized
From:   Kamal Heib <kamalheib1@gmail.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Date:   Wed, 22 May 2019 15:42:47 +0300
In-Reply-To: <20190522121513.GA6054@ziepe.ca>
References: <20190522072340.9042-1-kamalheib1@gmail.com>
         <20190522121513.GA6054@ziepe.ca>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, 2019-05-22 at 09:15 -0300, Jason Gunthorpe wrote:
> On Wed, May 22, 2019 at 10:23:40AM +0300, Kamal Heib wrote:
> > A panic could occur when calling ib_device_release() and port_data
> > isn't initialized, To avoid that a check was added to verify that
> > port_data isn't NULL.
> 
> This is a terrible commit message, describe the case that causes
> this.
> 

This happen if assign_name() return failure when called from
ib_register_device() - The following panic will happen and in every
function that touches the port_data's data members.

[   33.668236] BUG: unable to handle kernel NULL pointer dereference at
00000000000000c0
[   33.668238] #PF error: [WRITE]
[   33.668239] PGD 0 P4D 0 
[   33.668241] Oops: 0002 [#1] SMP PTI
[   33.668244] CPU: 19 PID: 1994 Comm: systemd-udevd Not tainted 5.1.0-
rc5+ #1
[   33.668245] Hardware name: HP ProLiant DL360p Gen8, BIOS P71
12/20/2013
[   33.668252] RIP: 0010:_raw_spin_lock_irqsave+0x1e/0x40
[   33.668254] Code: 85 ff 66 2e 0f 1f 84 00 00 00 00 00 66 66 66 66 90
53 9c 58 66 66 90 66 90 48 89 c3 fa 66 66 90 66 66 90 31 c0 ba 01 00 00
00 <f0> 0f b1 17 0f 94 c2 84 d2 74 05 48 89 d8 5b c3 89 c6 e8 b4 85 8a
[   33.668254] RSP: 0018:ffffa8d7079a7c08 EFLAGS: 00010046
[   33.668256] RAX: 0000000000000000 RBX: 0000000000000202 RCX:
ffffa8d7079a7bf8
[   33.668256] RDX: 0000000000000001 RSI: ffff93607c990000 RDI:
00000000000000c0
[   33.668257] RBP: 0000000000000001 R08: 0000000000000000 R09:
ffffffffc08c4dd8
[   33.668258] R10: 0000000000000000 R11: 0000000000000001 R12:
00000000000000c0
[   33.668259] R13: ffff93607c990000 R14: ffffffffc05a9740 R15:
ffffa8d7079a7e98
[   33.668260] FS:  00007f1c6ee438c0(0000) GS:ffff93609f6c0000(0000)
knlGS:0000000000000000
[   33.668261] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   33.668261] CR2: 00000000000000c0 CR3: 0000000819fca002 CR4:
00000000000606e0
[   33.668262] Call Trace:
[   33.668280]  free_netdevs+0x4d/0xe0 [ib_core]
[   33.668289]  ib_dealloc_device+0x51/0xb0 [ib_core]
[   33.668300]  __mlx5_ib_add+0x5e/0x70 [mlx5_ib]
[   33.668321]  mlx5_add_device+0x57/0xe0 [mlx5_core]
[   33.668335]  mlx5_register_interface+0x85/0xc0 [mlx5_core]
[   33.668337]  ? 0xffffffffc0474000
[   33.668340]  do_one_initcall+0x4e/0x1d4
[   33.668342]  ? _cond_resched+0x15/0x30
[   33.668345]  ? kmem_cache_alloc_trace+0x15f/0x1c0
[   33.668348]  do_init_module+0x5a/0x218
[   33.668350]  load_module+0x186b/0x1e40
[   33.668351]  ? m_show+0x1c0/0x1c0
[   33.668354]  __do_sys_finit_module+0x94/0xe0
[   33.668356]  do_syscall_64+0x5b/0x180
[   33.668358]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   33.668360] RIP: 0033:0x7f1c6daa0be9
[   33.668361] Code: 01 00 48 81 c4 80 00 00 00 e9 f1 fe ff ff 0f 1f 00
48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f
05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 57 e2 2c 00 f7 d8 64 89 01 48
[   33.668362] RSP: 002b:00007ffd2d71a3e8 EFLAGS: 00000246 ORIG_RAX:
0000000000000139
[   33.668363] RAX: ffffffffffffffda RBX: 00005576c3936f60 RCX:
00007f1c6daa0be9
[   33.668364] RDX: 0000000000000000 RSI: 00007f1c6e3c2039 RDI:
000000000000000e
[   33.668364] RBP: 00007f1c6e3c2039 R08: 0000000000000000 R09:
00005576c39374c0
[   33.668365] R10: 000000000000000e R11: 0000000000000246 R12:
0000000000000000
[   33.668365] R13: 00005576c39fd9a0 R14: 0000000000020000 R15:
0000000000000000
[   33.668367] Modules linked in: mlx5_ib(+) kvm irqbypass ib_uverbs
ipmi_ssif crct10dif_pclmul ib_core crc32_pclmul ghash_clmulni_intel
ipmi_si aesni_intel iTCO_wdt iTCO_vendor_support crypto_simd cryptd
glue_helper hpilo sg ipmi_devintf pcspkr ioatdma ipmi_msghandler hpwdt
acpi_power_meter pcc_cpufreq dca lpc_ich ip_tables xfs libcrc32c
mgag200 ata_generic sd_mod pata_acpi i2c_algo_bit drm_kms_helper
mlx5_core syscopyarea sysfillrect sysimgblt fb_sys_fops ttm tg3 mlxfw
drm ata_piix hpsa ptp libata crc32c_intel serio_raw pps_core
scsi_transport_sas dm_mirror dm_region_hash dm_log dm_mod
[   33.668387] CR2: 00000000000000c0
[   33.668414] ---[ end trace e1a60554f6535c71 ]---
[   33.675166] XFS (sda1): Mounting V5 Filesystem
[   33.676498] RIP: 0010:_raw_spin_lock_irqsave+0x1e/0x40
[   33.676500] Code: 85 ff 66 2e 0f 1f 84 00 00 00 00 00 66 66 66 66 90
53 9c 58 66 66 90 66 90 48 89 c3 fa 66 66 90 66 66 90 31 c0 ba 01 00 00
00 <f0> 0f b1 17 0f 94 c2 84 d2 74 05 48 89 d8 5b c3 89 c6 e8 b4 85 8a
[   33.676500] RSP: 0018:ffffa8d7079a7c08 EFLAGS: 00010046
[   33.676501] RAX: 0000000000000000 RBX: 0000000000000202 RCX:
ffffa8d7079a7bf8
[   33.676502] RDX: 0000000000000001 RSI: ffff93607c990000 RDI:
00000000000000c0
[   33.676503] RBP: 0000000000000001 R08: 0000000000000000 R09:
ffffffffc08c4dd8
[   33.676503] R10: 0000000000000000 R11: 0000000000000001 R12:
00000000000000c0
[   33.676504] R13: ffff93607c990000 R14: ffffffffc05a9740 R15:
ffffa8d7079a7e98
[   33.676505] FS:  00007f1c6ee438c0(0000) GS:ffff93609f6c0000(0000)
knlGS:0000000000000000
[   33.676506] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   33.676507] CR2: 00000000000000c0 CR3: 0000000819fca002 CR4:
00000000000606e0
[   33.676508] Kernel panic - not syncing: Fatal exception
[   33.706833] Kernel Offset: 0x2b200000 from 0xffffffff81000000
(relocation range: 0xffffffff80000000-0xffffffffbfffffff)

> The check should be in ib_device_release(), not in the functions.
> 
> Jason

Why? 

static void ib_device_release(struct device *device)
{
	struct ib_device *dev = container_of(device, struct ib_device,
dev);

	free_netdevs(dev);
	WARN_ON(refcount_read(&dev->refcount));
	ib_cache_release_one(dev);
	ib_security_release_port_pkey_list(dev);
	xa_destroy(&dev->compat_devs);
	xa_destroy(&dev->client_data);
	if (dev->port_data)
		kfree_rcu(container_of(dev->port_data, struct
ib_port_data_rcu,
				       pdata[0]),
			  rcu_head);
	kfree_rcu(dev, rcu_head);
}

Thanks,
Kamal

