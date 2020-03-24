Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E99F190338
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Mar 2020 02:16:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727036AbgCXBQR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 23 Mar 2020 21:16:17 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:45928 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727022AbgCXBQR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 23 Mar 2020 21:16:17 -0400
Received: by mail-qk1-f194.google.com with SMTP id c145so17664509qke.12
        for <linux-rdma@vger.kernel.org>; Mon, 23 Mar 2020 18:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DVu7TfCUO4nusENwKsGE8MaV0y3zkJr+KXau3nvD0x0=;
        b=e4oD8xRH2ZhmLyf4+4aweWnJT/ShTaTZbst/HVQfVVCNOTK8gRxuIPRZT3WBs9Q7Yw
         3VV1P4Y3VOQ7d32VLRl6zQTn2vSLXcinYGvacaX0fEznNiS1jKtbYKdANnNG91qbSgEu
         IKpDWSuoVTotQv/F9sUQyNUEWfyjRgITtE+XzcHwSnYFTDHuOwO/4sA6fWdAiLJtwFRI
         oDaglxoikr27oY4MaIds+2OxIMvAvIevNOIiX5BZDh7GLMdve3LIYHN5N6o9bBKzL9a3
         BNVf5xJEq+WcIOEAqg+SWF/YnKGk/8AQkPHc+JNGlof0blid2qkFzV4oTJ6zHch/rmz9
         /L5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DVu7TfCUO4nusENwKsGE8MaV0y3zkJr+KXau3nvD0x0=;
        b=IZHA/M1A3fBgS8bR5Ke3Bk3KuinP2Lk8uR7hm42xSMjBqSAyG7h93IQgbdL9/7vITk
         9hiiC5z1BsLaKOlDXD8tCbDjaC/7R/Lz/U5439v4hEAou0Jc9xbx5bO1y6X8ccuzDuT2
         4M4QQl7cwXQ98kU2DUN5vUzbd0C5aiRkqbU3JTBy0lBhHijxkZnm5YJwRgkqoOEd3EGV
         Fw3jdmuYEGpy/ZhzJZxkEtrDA6zLizELCkG30mHE1Q10Ee+69JW0sxPPFDbkVOYAHVNR
         ne5epSeHeJi0fgN3Jhljx+L67FdJS9tGgN27wuswar6NGaquxOf0PNOTFYV67GAoNa4s
         sB6Q==
X-Gm-Message-State: ANhLgQ1FqwRI4gWdl0WhDm7az1mQcxTtZWf0oarGa186YTjrh8KRTeMv
        5gQquLk6jEBH2wNByrCKvw3zLA==
X-Google-Smtp-Source: ADFU+vuruMyl0PJqRpHeO+vNZMLZIMIQz41vIv4QCcoT2/R1moHNwDeq0UhbIRifHZ8irJzeosyaIw==
X-Received: by 2002:a37:4bd3:: with SMTP id y202mr23987223qka.32.1585012575971;
        Mon, 23 Mar 2020 18:16:15 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id g3sm12117023qke.89.2020.03.23.18.16.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Mar 2020 18:16:15 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jGYAx-0000u0-26; Mon, 23 Mar 2020 22:16:15 -0300
Date:   Mon, 23 Mar 2020 22:16:15 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Mike Marciniszyn <mike.marciniszyn@intel.com>
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH v2] IB/hfi1: Insure pq is not left on waitlist
Message-ID: <20200324011615.GA3429@ziepe.ca>
References: <20200320200200.23203.37777.stgit@awfm-01.aw.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200320200200.23203.37777.stgit@awfm-01.aw.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Mar 20, 2020 at 04:02:10PM -0400, Mike Marciniszyn wrote:
> The following warning can occur when a pq is left on the
> dmawait list and the pq is then freed:
> 
> [3218804.385525] WARNING: CPU: 47 PID: 3546 at lib/list_debug.c:29 __list_add+0x65/0xc0
> [3218804.385527] list_add corruption. next->prev should be prev (ffff939228da1880), but was ffff939cabb52230. (next=ffff939cabb52230).
> [3218804.385528] Modules linked in: mmfs26(OE) mmfslinux(OE) tracedev(OE) 8021q garp mrp ib_isert iscsi_target_mod target_core_mod crc_t10dif crct10dif_generic opa_vnic rpcrdma ib_iser libiscsi scsi_transport_iscsi ib_ipoib(OE) bridge stp llc iTCO_wdt iTCO_vendor_support intel_powerclamp coretemp intel_rapl iosf_mbi kvm_intel kvm irqbypass crct10dif_pclmul crct10dif_common crc32_pclmul ghash_clmulni_intel aesni_intel lrw gf128mul glue_helper ablk_helper cryptd ast ttm drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops drm pcspkr joydev drm_panel_orientation_quirks i2c_i801 mei_me lpc_ich mei wmi ipmi_si ipmi_devintf ipmi_msghandler nfit libnvdimm acpi_power_meter acpi_pad hfi1(OE) rdmavt(OE) rdma_ucm ib_ucm ib_uverbs ib_umad rdma_cm ib_cm iw_cm ib_core binfmt_misc numatools(OE) xpmem(OE) ip_tables
> [3218804.385576] nfsv3 nfs_acl nfs lockd grace sunrpc fscache igb ahci libahci i2c_algo_bit dca libata ptp pps_core crc32c_intel [last unloaded: i2c_algo_bit]
> [3218804.385589] CPU: 47 PID: 3546 Comm: wrf.exe Kdump: loaded Tainted: G W OE ------------ 3.10.0-957.41.1.el7.x86_64 #1
> [3218804.385590] Hardware name: HPE.COM HPE SGI 8600-XA730i Gen10/X11DPT-SB-SG007, BIOS SBED1229 01/22/2019
> [3218804.385592] Call Trace:
> [3218804.385602] [<ffffffff91f65ac0>] dump_stack+0x19/0x1b
> [3218804.385607] [<ffffffff91898b78>] __warn+0xd8/0x100
> [3218804.385609] [<ffffffff91898bff>] warn_slowpath_fmt+0x5f/0x80
> [3218804.385616] [<ffffffff91a1dabe>] ? ___slab_alloc+0x24e/0x4f0
> [3218804.385618] [<ffffffff91b97025>] __list_add+0x65/0xc0
> [3218804.385642] [<ffffffffc03926a5>] defer_packet_queue+0x145/0x1a0 [hfi1]
> [3218804.385658] [<ffffffffc0372987>] sdma_check_progress+0x67/0xa0 [hfi1]
> [3218804.385673] [<ffffffffc03779d2>] sdma_send_txlist+0x432/0x550 [hfi1]
> [3218804.385676] [<ffffffff91a20009>] ? kmem_cache_alloc+0x179/0x1f0
> [3218804.385691] [<ffffffffc0392973>] ? user_sdma_send_pkts+0xc3/0x1990 [hfi1]
> [3218804.385704] [<ffffffffc0393e3a>] user_sdma_send_pkts+0x158a/0x1990 [hfi1]
> [3218804.385707] [<ffffffff918ab65e>] ? try_to_del_timer_sync+0x5e/0x90
> [3218804.385710] [<ffffffff91a3fe1a>] ? __check_object_size+0x1ca/0x250
> [3218804.385723] [<ffffffffc0395546>] hfi1_user_sdma_process_request+0xd66/0x1280 [hfi1]
> [3218804.385737] [<ffffffffc034e0da>] hfi1_aio_write+0xca/0x120 [hfi1]
> [3218804.385739] [<ffffffff91a4245b>] do_sync_readv_writev+0x7b/0xd0
> [3218804.385742] [<ffffffff91a4409e>] do_readv_writev+0xce/0x260
> [3218804.385746] [<ffffffff918df69f>] ? pick_next_task_fair+0x5f/0x1b0
> [3218804.385748] [<ffffffff918db535>] ? sched_clock_cpu+0x85/0xc0
> [3218804.385751] [<ffffffff91f6b16a>] ? __schedule+0x13a/0x860
> [3218804.385752] [<ffffffff91a442c5>] vfs_writev+0x35/0x60
> [3218804.385754] [<ffffffff91a4447f>] SyS_writev+0x7f/0x110
> [3218804.385757] [<ffffffff91f78ddb>] system_call_fastpath+0x22/0x27
> 
> The issue happens when wait_event_interruptible_timeout() returns a
> value <= 0.
> 
> In that case, the pq is left on the list.   The code continues sending
> packets and potentially can complete the current request with the pq
> still on the dmawait list provided no descriptor shortage is seen.
> 
> If the pq is torn down in that state, the sdma interrupt handler could
> find the now freed pq on the list with list corruption or memory
> corruption resulting.
> 
> Fix by adding a flush routine to ensure that the pq is never on a list
> after processing a request.
> 
> A follow-up patch series will address issues with seqlock surfaced in:
> https://lore.kernel.org/linux-rdma/20200320003129.GP20941@ziepe.ca
> 
> The seqlock use for sdma will then be converted to a spin lock since
> the list_empty() doesn't need the protection afforded by the sequence
> probes currently in use.
> 
> Fixes: a0d406934a46 ("staging/rdma/hfi1: Add page lock limit check for SDMA requests")
> Reviewed-by: Kaike Wan <kaike.wan@intel.com>
> Signed-off-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
> Signed-off-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
> ---
> v1 => v2:
> - s/insure/ensure/

Not all of them, but I fixed it.

Applied to for-rc

Thanks,
Jason
