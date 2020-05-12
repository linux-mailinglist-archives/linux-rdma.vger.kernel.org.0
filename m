Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44DFF1D0140
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2020 23:50:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731389AbgELVuH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 12 May 2020 17:50:07 -0400
Received: from mail-pl1-f179.google.com ([209.85.214.179]:33308 "EHLO
        mail-pl1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728313AbgELVuG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 12 May 2020 17:50:06 -0400
Received: by mail-pl1-f179.google.com with SMTP id t7so5986809plr.0
        for <linux-rdma@vger.kernel.org>; Tue, 12 May 2020 14:50:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:autocrypt:message-id:date
         :user-agent:mime-version:content-language:content-transfer-encoding;
        bh=By1SypfjAju2cjO2b6lyDyDWiZbxucCg3oMquVnYZ2E=;
        b=Sxb2uiWNR0VInb6vuxZKWCsR6IqCA6WziBN2jufqv9JX/sAy3TG/JSQv0id55HtojF
         zfUtgsXuL4NjvmmTvT8m8/trfsp86fKj3Yd6o3FyZ5CGBtjdkltDc0aacWM60ZqKpm2v
         RbFM7bk23CbvRaZ6PkDoYm5pzpAWF9NeTua6Wrspdgo2WmYablliAw2DE3RjejDAZ4Lw
         kZVocjVhzmoZ6cvpb/jeqVj2ycI2v2Q7J/iJsrHcgJKlY6rcpVERxS1ot47/4aySPQ4j
         lyl4LWgV0hLQfcnh0f7iL23Oi2HJTHudv9DqbB8591srl8X/28wSI18AI84M6sFHnQN0
         NXOw==
X-Gm-Message-State: AGi0PuYpAvWKPGnH5uKeFrhSF7C1PHteTmAINN36zg+jWGNkUn/hr2Pm
        wHkjJ1Cw3cOYRcl/IP5ag0sA+oow
X-Google-Smtp-Source: APiQypIhCFESgZZUGkOhTFuNg++F40T7lnMXxQW6Zc2HqKduX7ARlpPa/24nDI6PzVhRMdCChre4JA==
X-Received: by 2002:a17:902:7481:: with SMTP id h1mr22046816pll.193.1589320205494;
        Tue, 12 May 2020 14:50:05 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:d1a1:34bc:ea5:fadd? ([2601:647:4000:d7:d1a1:34bc:ea5:fadd])
        by smtp.gmail.com with ESMTPSA id ce21sm13604973pjb.51.2020.05.12.14.50.03
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 May 2020 14:50:04 -0700 (PDT)
To:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
From:   Bart Van Assche <bvanassche@acm.org>
Subject: Mellanox ConnectX-3 and vfio
Autocrypt: addr=bvanassche@acm.org; prefer-encrypt=mutual; keydata=
 mQENBFSOu4oBCADcRWxVUvkkvRmmwTwIjIJvZOu6wNm+dz5AF4z0FHW2KNZL3oheO3P8UZWr
 LQOrCfRcK8e/sIs2Y2D3Lg/SL7qqbMehGEYcJptu6mKkywBfoYbtBkVoJ/jQsi2H0vBiiCOy
 fmxMHIPcYxaJdXxrOG2UO4B60Y/BzE6OrPDT44w4cZA9DH5xialliWU447Bts8TJNa3lZKS1
 AvW1ZklbvJfAJJAwzDih35LxU2fcWbmhPa7EO2DCv/LM1B10GBB/oQB5kvlq4aA2PSIWkqz4
 3SI5kCPSsygD6wKnbRsvNn2mIACva6VHdm62A7xel5dJRfpQjXj2snd1F/YNoNc66UUTABEB
 AAG0JEJhcnQgVmFuIEFzc2NoZSA8YnZhbmFzc2NoZUBhY20ub3JnPokBOQQTAQIAIwUCVI67
 igIbAwcLCQgHAwIBBhUIAgkKCwQWAgMBAh4BAheAAAoJEHFcPTXFzhAJ8QkH/1AdXblKL65M
 Y1Zk1bYKnkAb4a98LxCPm/pJBilvci6boefwlBDZ2NZuuYWYgyrehMB5H+q+Kq4P0IBbTqTa
 jTPAANn62A6jwJ0FnCn6YaM9TZQjM1F7LoDX3v+oAkaoXuq0dQ4hnxQNu792bi6QyVdZUvKc
 macVFVgfK9n04mL7RzjO3f+X4midKt/s+G+IPr4DGlrq+WH27eDbpUR3aYRk8EgbgGKvQFdD
 CEBFJi+5ZKOArmJVBSk21RHDpqyz6Vit3rjep7c1SN8s7NhVi9cjkKmMDM7KYhXkWc10lKx2
 RTkFI30rkDm4U+JpdAd2+tP3tjGf9AyGGinpzE2XY1K5AQ0EVI67igEIAKiSyd0nECrgz+H5
 PcFDGYQpGDMTl8MOPCKw/F3diXPuj2eql4xSbAdbUCJzk2ETif5s3twT2ER8cUTEVOaCEUY3
 eOiaFgQ+nGLx4BXqqGewikPJCe+UBjFnH1m2/IFn4T9jPZkV8xlkKmDUqMK5EV9n3eQLkn5g
 lco+FepTtmbkSCCjd91EfThVbNYpVQ5ZjdBCXN66CKyJDMJ85HVr5rmXG/nqriTh6cv1l1Js
 T7AFvvPjUPknS6d+BETMhTkbGzoyS+sywEsQAgA+BMCxBH4LvUmHYhpS+W6CiZ3ZMxjO8Hgc
 ++w1mLeRUvda3i4/U8wDT3SWuHcB3DWlcppECLkAEQEAAYkBHwQYAQIACQUCVI67igIbDAAK
 CRBxXD01xc4QCZ4dB/0QrnEasxjM0PGeXK5hcZMT9Eo998alUfn5XU0RQDYdwp6/kMEXMdmT
 oH0F0xB3SQ8WVSXA9rrc4EBvZruWQ+5/zjVrhhfUAx12CzL4oQ9Ro2k45daYaonKTANYG22y
 //x8dLe2Fv1By4SKGhmzwH87uXxbTJAUxiWIi1np0z3/RDnoVyfmfbbL1DY7zf2hYXLLzsJR
 mSsED/1nlJ9Oq5fALdNEPgDyPUerqHxcmIub+pF0AzJoYHK5punqpqfGmqPbjxrJLPJfHVKy
 goMj5DlBMoYqEgpbwdUYkH6QdizJJCur4icy8GUNbisFYABeoJ91pnD4IGei3MTdvINSZI5e
Message-ID: <24881332-5456-5284-1c2c-074a1476ac87@acm.org>
Date:   Tue, 12 May 2020 14:50:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi,

When I tried to assign a ConnectX-3 HCA to Qemu using vfio, the
following error message appeared in the kernel log:

[ 2238.319227] genirq: Flags mismatch irq 16. 00000000
(vfio-intx(0000:01:00.0)) vs. 00000080 (ehci_hcd:usb1)

From linux/interrupt.h:

	#define IRQF_SHARED		0x00000080

In vfio_pci.c I found the following:

	vdev->pci_2_3 = pci_intx_mask_supported(pdev);

and in drivers/pci/quirks.c I found the following:

static u16 mellanox_broken_intx_devs[] = {
	PCI_DEVICE_ID_MELLANOX_HERMON_SDR,
	PCI_DEVICE_ID_MELLANOX_HERMON_DDR,
	PCI_DEVICE_ID_MELLANOX_HERMON_QDR,
	PCI_DEVICE_ID_MELLANOX_HERMON_DDR_GEN2,
	PCI_DEVICE_ID_MELLANOX_HERMON_QDR_GEN2,
	PCI_DEVICE_ID_MELLANOX_HERMON_EN,
	PCI_DEVICE_ID_MELLANOX_HERMON_EN_GEN2,
	PCI_DEVICE_ID_MELLANOX_CONNECTX_EN,
	PCI_DEVICE_ID_MELLANOX_CONNECTX_EN_T_GEN2,
	PCI_DEVICE_ID_MELLANOX_CONNECTX_EN_GEN2,
	PCI_DEVICE_ID_MELLANOX_CONNECTX_EN_5_GEN2,
	PCI_DEVICE_ID_MELLANOX_CONNECTX2,
	PCI_DEVICE_ID_MELLANOX_CONNECTX3,
	PCI_DEVICE_ID_MELLANOX_CONNECTX3_PRO,
};

static void mellanox_check_broken_intx_masking(struct pci_dev *pdev)
{
	__be32 __iomem *fw_ver;
	u16 fw_major;
	u16 fw_minor;
	u16 fw_subminor;
	u32 fw_maj_min;
	u32 fw_sub_min;
	int i;

	for (i = 0; i < ARRAY_SIZE(mellanox_broken_intx_devs); i++) {
		if (pdev->device == mellanox_broken_intx_devs[i]) {
			pdev->broken_intx_masking = 1;
			return;
		}
	}
	[ ... ]
}

I think that code was added by commit d76d2fe05fd9 ("PCI: Convert
Mellanox broken INTx quirks to be for listed devices only").

Does anyone know whether the mellanox_broken_intx_devs[] table is
up-to-date? I'm using a ConnectX-3 VPI adapter and have installed the
latest firmware:

# mstflint -d 01:00.0 q
Image type:            FS2
FW Version:            2.42.5000
FW Release Date:       5.9.2017
Product Version:       02.42.50.00
Rom Info:              type=PXE version=3.4.752
Device ID:             4099
Description:           Node             Port1            Port2
 Sys image
GUIDs:                 [ ... ]
MACs:                  [ ... ]
VSD:
PSID:                  MT_1090120019

Thanks,

Bart.
