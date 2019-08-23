Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10FF19B8B4
	for <lists+linux-rdma@lfdr.de>; Sat, 24 Aug 2019 01:02:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726378AbfHWXCq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 23 Aug 2019 19:02:46 -0400
Received: from mail-pf1-f172.google.com ([209.85.210.172]:42906 "EHLO
        mail-pf1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbfHWXCp (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 23 Aug 2019 19:02:45 -0400
Received: by mail-pf1-f172.google.com with SMTP id i30so7441869pfk.9
        for <linux-rdma@vger.kernel.org>; Fri, 23 Aug 2019 16:02:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=3VU/a/WV3CucsoLfYy+9X5VdQSeMRLMiGTmnNwiYjXQ=;
        b=QVJnnR4WB0JEMqKMCqPBaKfrR13n3UBDXXyVkFL5wKJxs7nN9KQxIr/3cHAlywW2AH
         NU4occX/bMwa6z6gXJGk92yn3T/yq1ZXGdWG13nVgteJCEEk/0zMnoE5Xx9iyn/0gSSs
         cLmrklngMu7DGODA/mML575T2PNyajRKve7rpRdGqKJUDrxytcIePbuaU6skywXD+Lac
         m3+pHLNiyOsBZPzlGKI7TSdHFegythmul8VEPpGF96Lpb32LHGiGFM3kYh1rwTIjwnpw
         9yTEuCeWcU5UBSvo925B+A+HvHtA6T8lm4oCJzG/A5vgA7teeQx64JcB0BeV8DF8ZSpa
         u2yQ==
X-Gm-Message-State: APjAAAW9ExkB82D+DpgwrvS6+K0guL3KUuV9oBHAIwcpmXc5eemwtjn+
        AQmCCtMzyJf16TacS7+i/tjpAYfH
X-Google-Smtp-Source: APXvYqzU6SxAzOXoUR+w+ahXyAOIKDuae/954Vv26Cl+ankT2dmHCh+lABHhKofC1/WRYsBnjuY8QQ==
X-Received: by 2002:a63:fc52:: with SMTP id r18mr6030059pgk.378.1566601364469;
        Fri, 23 Aug 2019 16:02:44 -0700 (PDT)
Received: from asus.site ([2601:647:4000:1349:56c2:95e9:3c7:9c11])
        by smtp.gmail.com with ESMTPSA id u74sm9242567pjb.26.2019.08.23.16.02.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Aug 2019 16:02:43 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
Subject: siw trigger BUG: sleeping function called from invalid context at
 mm/slab.h:50
To:     Bernard Metzler <bmt@zurich.ibm.com>, linux-rdma@vger.kernel.org
Message-ID: <6ed77231-800b-f629-5d15-14409f0777c7@acm.org>
Date:   Fri, 23 Aug 2019 16:02:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Bernard,

If I try to associate the ib_srpt driver with the siw driver the
complaint shown below appears on the console. In iw_cm_listen() I
found the following:

         [ ... ]
	spin_lock_irqsave(&cm_id_priv->lock, flags);
	switch (cm_id_priv->state) {
	case IW_CM_STATE_IDLE:
		cm_id_priv->state = IW_CM_STATE_LISTEN;
		spin_unlock_irqrestore(&cm_id_priv->lock, flags);
		ret = iw_cm_map(cm_id, false);
		if (!ret)
			ret = cm_id->device->ops.iw_create_listen(cm_id,
								  backlog);
		if (ret)
			cm_id_priv->state = IW_CM_STATE_IDLE;
		spin_lock_irqsave(&cm_id_priv->lock, flags);
		break;
	default:
		ret = -EINVAL;
	}
	spin_unlock_irqrestore(&cm_id_priv->lock, flags);
         [ ... ]

So it surprises me that siw_listen_address() calls a function that
can sleep. Do you think this is a correct analysis of the call trace
shown below?

Thanks,

Bart.

Target_Core_ConfigFS: REGISTER -> Allocated Fabric: srpt
iwpm_register_pid: Unable to send a nlmsg (client = 2)
BUG: sleeping function called from invalid context at mm/slab.h:501
in_atomic(): 1, irqs_disabled(): 0, pid: 1097, name: restart-lio-srp
4 locks held by restart-lio-srp/1097:
  #0: 0000000083aba319 (sb_writers#11){.+.+}, at: vfs_write+0x24a/0x2c0
  #1: 00000000dc6d2df5 (&buffer->mutex){+.+.}, at: configfs_write_file+0x4e/0x1d0 [configfs]
  #2: 000000004db62204 (lock#7){+.+.}, at: rdma_listen+0x34c/0x450 [rdma_cm]
  #3: 00000000ca45d89f (&ndev->lock){++--}, at: siw_create_listen+0x1d1/0x8b0 [siw]
Preemption disabled at:
[<ffffffffa0db6071>] siw_create_listen+0x1d1/0x8b0 [siw]
CPU: 0 PID: 1097 Comm: restart-lio-srp Not tainted 5.3.0-rc5-dbg+ #2
Hardware name: Bochs Bochs, BIOS Bochs 01/01/2011
Call Trace:
  dump_stack+0x8a/0xd6
  ___might_sleep.cold+0x128/0x139
  __might_sleep+0x76/0xe0
  kmem_cache_alloc+0x2b4/0x3a0
  sock_alloc_inode+0x20/0xf0
  alloc_inode+0x34/0xe0
  new_inode_pseudo+0x17/0x90
  sock_alloc+0x2f/0x110
  __sock_create+0x61/0x360
  sock_create+0x5f/0x70
  siw_listen_address+0xbe/0x630 [siw]
  siw_create_listen+0x2f5/0x8b0 [siw]
  iw_cm_listen+0xd9/0x110 [iw_cm]
  rdma_listen+0x32e/0x450 [rdma_cm]
  cma_listen_on_dev+0x276/0x290 [rdma_cm]
  rdma_listen+0x3c7/0x450 [rdma_cm]
  srpt_create_rdma_id+0xc8/0x120 [ib_srpt]
  srpt_rdma_cm_port_store+0x1a0/0x1f0 [ib_srpt]
  configfs_write_file+0x15c/0x1d0 [configfs]
  __vfs_write+0x4c/0x90
  vfs_write+0x145/0x2c0
  ksys_write+0xd7/0x180
  __x64_sys_write+0x47/0x50
  do_syscall_64+0x75/0x280
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
[...]
siw: device registration error -23
