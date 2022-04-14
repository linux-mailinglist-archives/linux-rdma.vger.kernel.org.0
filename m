Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 822BE501F1F
	for <lists+linux-rdma@lfdr.de>; Fri, 15 Apr 2022 01:31:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347634AbiDNXeR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 14 Apr 2022 19:34:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347713AbiDNXeM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 14 Apr 2022 19:34:12 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9B7CADD62;
        Thu, 14 Apr 2022 16:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=THbOh/alt3AK6ca8dDqbIGoW0oPlPwii7CF9tHVrcWs=; b=xeiF+wNU3ob/bqZINBFTvp7awU
        fyVaHVBC/sO8+ZAQZMxwdV+N9L7VDMzMg1ar4kKmf14bpr2XsQv+l1s6TLl1BGrGwaZux3JWpW4LF
        elEAFkGnt7MdrO1YOClQVZdE2rFvZZk5ztfDf8kPvtBqszvBnwjvc31KepHbLz4TOn2IjL9V+8Cir
        yk60yXV1JF0a9/+bLt3Rse/sp61nvUXGlwlwk2Tzogiw/QOfORJcLCKWGJgX4ndz6JJ224iQYkxKA
        GjGqQINcbFq3ok2tE4nby5+5imt81wv9HH21eFabGdDORKH8jyGxKbGsUep+VYiH7ON75Ry3zfHzO
        wca3PzSw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nf8w5-007nAD-Q8; Thu, 14 Apr 2022 23:31:37 +0000
Date:   Thu, 14 Apr 2022 16:31:37 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Bernard Metzler <bmt@zurich.ibm.com>,
        Bart Van Assche <bvanassche@acm.org>
Cc:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
        Pankaj Raghav <pankydev8@gmail.com>,
        Pankaj Raghav <p.raghav@samsung.com>, mcgrof@kernel.org
Subject: siw_cm.c:255 siw_cep_put+0x125/0x130 kernel warning while testing
 blktests srp/002 v5.17-rc7
Message-ID: <Yliu2ROIh0nLk5l0@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

If you run blktests srp/002 in a loop you can eventually run into
the kernel warning as in the end of this email. You can easily
reproduce by getting kdevops [0], enabling the srp guest and just
using the following steps:

make menuconfig # enable linux-v5.17-rc7, blktests and just the srp tests
make
make bringup # bring up guests
make linux # build and install v5.17-rc7 on guests
make blktests # build and install blktests dependencies and srp dependencies

Assuming you used CONFIG_KDEVOPS_HOSTS_PREFIX=3D"linux517" and you
just enabled thew srp tests for blktests, you will end up with the
guests:

  * linux517-blktests-srp
  * linux517-blktests-srp-dev

So you can ssh to them and run tests manually if you want:

ssh linux517-blktests-srp
sudo su -
cd /usr/local/blktests
i=3D0; while true; do use_siw=3D1 ./check -q srp/002; if [[ $? -ne 0 ]]; th=
en echo "BAD at $i"; break; else echo GOOOD $i ; fi; let i=3D$i+1; done;

[  171.959312] run blktests srp/002 at 2022-04-14 01:29:08
[  172.177267] null_blk: module loaded
[  172.257984] SoftiWARP attached
<-- snip -->
[  195.215244] ib_srp:srp_max_it_iu_len: ib_srp: max_iu_len =3D 8260
[  195.218424] sd 3:0:0:2: [sdc] Attached SCSI disk
[  195.218783] ------------[ cut here ]------------
[  195.221242] WARNING: CPU: 7 PID: 201 at drivers/infiniband/sw/siw/siw_cm=
=2Ec:255 siw_cep_put+0x125/0x130 [siw]
[  195.222838] Modules linked in: ib_srp(E) scsi_transport_srp(E) target_co=
re_pscsi(E) target_core_file(E) ib_srpt(E) target_core_iblock(E) target_cor=
e_mod(E) rdma_cm(E) iw_cm(E) ib_cm(E) scsi_debug(E) siw(E) null_blk(E) ib_u=
mad(E) ib_uverbs(E) sd_mod(E) sg(E) dm_service_time(E) scsi_dh_rdac(E) scsi=
_dh_emc(E) scsi_dh_alua(E) dm_multipath(E) ib_core(E) dm_mod(E) nvme_fabric=
s(E) kvm_intel(E) kvm(E) irqbypass(E) crct10dif_pclmul(E) ghash_clmulni_int=
el(E) aesni_intel(E) crypto_simd(E) cryptd(E) joydev(E) evdev(E) serio_raw(=
E) cirrus(E) drm_shmem_helper(E) drm_kms_helper(E) virtio_balloon(E) cec(E)=
 i6300esb(E) button(E) drm(E) configfs(E) ip_tables(E) x_tables(E) autofs4(=
E) ext4(E) crc16(E) mbcache(E) jbd2(E) btrfs(E) blake2b_generic(E) xor(E) r=
aid6_pq(E) zstd_compress(E) libcrc32c(E) crc32c_generic(E) virtio_net(E) ne=
t_failover(E) failover(E) virtio_blk(E) ata_generic(E) uhci_hcd(E) ehci_hcd=
(E) crc32_pclmul(E) crc32c_intel(E) ata_piix(E) psmouse(E) nvme(E) libata(E=
) virtio_pci(E)
[  195.222986]  virtio_pci_legacy_dev(E) virtio_pci_modern_dev(E) usbcore(E=
) virtio(E) usb_common(E) scsi_mod(E) nvme_core(E) i2c_piix4(E) virtio_ring=
(E) t10_pi(E) scsi_common(E) [last unloaded: null_blk]
[  195.241036] sd 3:0:0:1: [sdd] Attached SCSI disn
[  195.241188] CPU: 2 PID: 201 Comm: kworker/u16:22 Kdump: loaded Tainted: =
G            E     5.17.0-rc7 #1
[  195.246053] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.15.0-1 04/01/2014
[  195.249123] Workqueue: iw_cm_wq cm_work_handler [iw_cm]
[  195.251274] RIP: 0010:siw_cep_put+0x125/0x130 [siw]
[  195.253548] Code: bb c0 e8 ae 74 0f d7 48 89 ef 5d 41 5c 41 5d e9 b1 d6 =
ef d6 5d be 03 00 00 00 41 5c 41 5d e9 22 b7 0c d7 0f 0b e9 f3 fe ff ff <0f=
> 0b e9 1c ff ff ff 0f 1f 40 00 0f 1f 44 00 00 55 48 8d 6f 20 53
[  195.258982] RSP: 0018:ffffbc53404ebc98 EFLAGS: 00010286
[  195.261018] RAX: 0000000000000001 RBX: 0000000000000000 RCX: 00000000000=
00000
[  195.263569] RDX: 0000000000000001 RSI: 0000000000000246 RDI: ffffa03d110=
2a924
[  195.266151] RBP: ffffa03d1102a900 R08: ffffa03d1102a920 R09: ffffbc53404=
ebc50
[  195.269150] R10: ffffffff98a060e0 R11: 0000000000000000 R12: ffffa03cc42=
97000
[  195.272744] R13: ffffa03d2a48aea0 R14: ffffa03d2a48ae78 R15: ffffa03cc42=
7ad58
[  195.275575] FS:  0000000000000000(0000) GS:ffffa03df7c80000(0000) knlGS:=
0000000000000000
[  195.278932] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  195.280963] CR2: 00005590bc2e4fe8 CR3: 000000008500a004 CR4: 00000000007=
70ee0
[  195.282803] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000000=
00000
[  195.284650] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000000000=
00400
[  195.286522] PKRU: 55555554
[  195.287998] Call Trace:
[  195.289210]  <TASK>
[  195.290969]  siw_reject+0xac/0x180 [siw]
[  195.292679]  iw_cm_reject+0x68/0xc0 [iw_cm]
[  195.294136]  cm_work_handler+0x59d/0xe20 [iw_cm]
[  195.295588]  process_one_work+0x1e2/0x3b0
[  195.298338]  worker_thread+0x50/0x3a0
[  195.300330]  ? rescuer_thread+0x390/0x390
[  195.302269]  kthread+0xe5/0x110
[  195.304062]  ? kthread_complete_and_exit+0x20/0x20
[  195.307612]  ret_from_fork+0x1f/0x30
[  195.309585]  </TASK>
[  195.310674] ---[ end trace 0000000000000000 ]---
[  195.313290] scsi host4: ib_srp: REJ received
[  195.313293] scsi host4:   REJ reason 0xffffff98
[  195.315433] scsi host4: ib_srp: Connection 0/8 to 172.17.8.113 failed
[  195.472718] ib_srp:srp_parse_in: ib_srp: 172.17.8.113 -> 172.17.8.113:0
[  195.472739] ib_srp:srp_parse_in: ib_srp: 172.17.8.113:5555 -> 172.17.8.1=
13:5555
[  195.472807] ib_srp:srp_parse_in: ib_srp: [fe80::5054:ff:fe5b:90dc%3] -> =
[fe80::5054:ff:fe5b:90dc]:0/202442865%3

[0] https://github.com/mcgrof/kdevops

  Luis
