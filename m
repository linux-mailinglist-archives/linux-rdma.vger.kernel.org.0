Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86595270BF0
	for <lists+linux-rdma@lfdr.de>; Sat, 19 Sep 2020 10:46:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726129AbgISIq3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 19 Sep 2020 04:46:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726054AbgISIq2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 19 Sep 2020 04:46:28 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D94DC0613CE
        for <linux-rdma@vger.kernel.org>; Sat, 19 Sep 2020 01:46:28 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id g29so4904367pgl.2
        for <linux-rdma@vger.kernel.org>; Sat, 19 Sep 2020 01:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language;
        bh=g3BLCJGY0rgPIvaZfRRHf/x1DeLCrEzH0CeNcygeHHo=;
        b=Lhb2FqeC8V/aMOgCgaaw02iY5vnPCSgqC0U5KdHaj74PAAmL3bzcfLjyjioZOLW3oX
         2cBoKZlI21sk4Y7UjxQEC9NR+4u3owUC86UoRgpyZQt14MOFOKLNU7It2xOxbmLizMDi
         kPNfjv0FixYDDj8HUwCt5O9xK8WrMuRqSTETvqVFo2h7kOtlWbZM+hbar/DMhaO/FYXM
         r/FQKHA2gm3XLY4c0oM4n3sJ/2SekgJu3A3lS9XA8vlGEJkVILFl4OZpw2ui/Eljo5Sc
         gN1MUTFDho8xqyJKLRlz9SXM+Oaf3/XrbIpowvyqvAkF5Eol1lvntMQzfbzHzexf0Wez
         WkkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language;
        bh=g3BLCJGY0rgPIvaZfRRHf/x1DeLCrEzH0CeNcygeHHo=;
        b=pIG2iOrTXQlcB9rzszdqlK+WTXwMpdApVz/jGQChAR2g6PpI2M6f0nMT5eRa0D/suu
         yEYKZpRSVEeCIPAIllKu/wsciFGzGyzMYf7j6jpIqY6fiDa5UnvFVGtOtTkU+IzPZNCh
         /qktpxcbJB/G3m7RxMwOaGOkwvkeKLn3D/g32dUib49YEUwXTraonyQ703kI/J/ymVb7
         PpumOzVD/Ie1uh8oAf1wpdJNZmQoVJfPb7Q44jthLUpwRHY1uwUe7IjqTL2sTFQkqrPJ
         ddzecBb7p17u3/75Nc91lT6AJo5HmmreVXwmXiHvWoWMCjZBpUhoFpwibuH5rF4057D2
         dv8Q==
X-Gm-Message-State: AOAM531GF0Qr66HTNqyoDPPgPjNmce3CGqdlTqa+J0WX1HB+jBXMnRTp
        /pVtMJ9dk+vgrp40P64uIU4=
X-Google-Smtp-Source: ABdhPJzFcFDnmdOeuvIRMwZmCz0+YutL3HzJZ2hJV9+kF3LDPxNa4lJhGdejAOytRapGXQAogPdk/A==
X-Received: by 2002:a05:6a00:844:b029:13f:dd99:d1a4 with SMTP id q4-20020a056a000844b029013fdd99d1a4mr27715915pfk.31.1600505188113;
        Sat, 19 Sep 2020 01:46:28 -0700 (PDT)
Received: from [10.75.201.17] ([129.126.144.50])
        by smtp.gmail.com with ESMTPSA id m25sm5666270pfa.32.2020.09.19.01.46.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Sep 2020 01:46:27 -0700 (PDT)
Subject: Re: [PATCH for-next v5 00/12] rdma_rxe: API extensions
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Bob Pearson <rpearsonhpe@gmail.com>
Cc:     linux-rdma@vger.kernel.org, Bob Pearson <rpearson@hpe.com>
References: <20200918211517.5295-1-rpearson@hpe.com>
 <20200918235117.GK3699@nvidia.com>
 <ec3bf0ed-8dde-5f36-656f-3cf6d64bd7a2@gmail.com>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Message-ID: <088207e0-bdaf-0d0c-62b9-612941825ca8@gmail.com>
Date:   Sat, 19 Sep 2020 16:46:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <ec3bf0ed-8dde-5f36-656f-3cf6d64bd7a2@gmail.com>
Content-Type: multipart/mixed;
 boundary="------------D46A12E6EA390D9FC6AE94D0"
Content-Language: en-US
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This is a multi-part message in MIME format.
--------------D46A12E6EA390D9FC6AE94D0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/19/2020 4:44 PM, Zhu Yanjun wrote:
>
> On 9/19/2020 7:51 AM, Jason Gunthorpe wrote:
>> On Fri, Sep 18, 2020 at 04:15:05PM -0500, Bob Pearson wrote:
>>> This patch series is a collection of API extensions for the rdma_rxe 
>>> driver.
>>> With this patch set installed there are no errors in pyverbs 
>>> run-tests and
>>> 31 tests are skipped down from 56. The remaining skipped test cases 
>>> include
>>>     - XRC tests
>>>     - ODP tests
>>>     - Parent device tests
>>>     - Import tests
>>>     - Device memory
>>>     - MLX5 specific tests
>>>     - EFA tests
>> It seems like a big improvement! Thanks!
>>
>> Zhu, can you look through this too?
>
> OK. It seems that a problem occurred in this patch set.
>
> Hi, Bob
>
> Please fix this problem. Thanks a lot.

The problem mail is in the attachment. Please check and fix it.

Zhu Yanjun

>
> Zhu Yanjun
>
>>
>> Jason
>>
>>> It continues from the previous (v4) set which implemented memory 
>>> windows and
>>> has had a number of individual patches picked up in for-next.
>>>
>>> This set (v5) includes:
>>>     Ported to current head of tree
>>>     Memory windows patches not yet picked up
>>>     kernel support for the extended user space APIs:
>>>       - ibv_query_device_ex
>>>       - ibv_create_cq_ex
>>>       - ibv_create_qp_ex
>>>     Fixes for multicast which is not currently working
>> I would like to progress the simple independent obviously OK bits,
>> could you split them out?
>>
>> Jason



--------------D46A12E6EA390D9FC6AE94D0
Content-Type: message/rfc822;
 name="Re [PATCH for-next v5 06_12] rdma_rxe Add memory access through
 MWs.eml"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="Re  [PATCH for-next v5 06_12] rdma_rxe  Add memory access th";
 filename*1="rough MWs.eml"

X-Mozilla-Keys:                                                                                 
Delivered-To: zyjzyj2000@gmail.com
Received: by 2002:a05:6830:1349:0:0:0:0 with SMTP id r9csp2147460otq;
        Fri, 18 Sep 2020 20:52:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyxhv1xyCIQYwR8LwwBJI92+Xlibcz25ZVqfozzb8AZPLH3bmSuQHk9I/0xWpSOLdb+Lmso
X-Received: by 2002:a17:902:a612:b029:d1:ece5:a1ce with SMTP id u18-20020a170902a612b02900d1ece5a1cemr15363347plq.66.1600487576189;
        Fri, 18 Sep 2020 20:52:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1600487576; cv=none;
        d=google.com; s=arc-20160816;
        b=lYcX0wqVt9NrD3AGNx1ZspOGbcWoQNi/qqRJW35fQu6qYPpX2Uk3ET78WCVr9Wbqud
         SfWOC9rtGBh64RyS0Zdo8xKAkQQG7YbcIPXjif1/v6ZNnnbCIMlrMYVR5t4BG/ezJ3lX
         9bivnrUynkm+rMXkZunZF8hxdB6pjweKi/J9zipWW1zPo6mKyNqHRFAVSgqPdKcbsSqD
         oryn62On8Z8S7Z9VioV7TYOF8VdGvEYmMTNVzSjDCueB04BCAa8uqi1IIQURQF5y3S7G
         e+Djo+h+ToIRa4EnDrrFJoCVLMJTzAJ2FMyF8TMYMzIObkTMrlIcJnmwGlN4+EJdjjsa
         5OLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:ironport-sdr:ironport-sdr;
        bh=oIhdZQ2Ldp+AhjULk+QMKFsXZ1dzDJwNy3j09kH1UcY=;
        b=c5hZ7WT0/rYzVA+w7a1CdS7s19F/yB0WswJ1jzgkN54FyWjPvwd9jt3It9E47QnpvG
         q8YAR3jYWAEmDPxl3HfxxpJA8Eg7NPaP0uqeiRU7mFWVzdrAJqH/RwBWijJ5dsogLFoL
         83+Hb74mfEt5m0emT9kKqcW4jXegDgRWzE13RUxJItZSgB0OnTTw6I1fqhoHkGbDCide
         K9nyGyLwsClsdviMRRZE8dCwbKuRrIYrcOUqYRsjjm8RUrEQNPdZXCJUboY9kiJd+vX3
         MtS7uTbqom129hSoTxHs0PBRD1o+nT7bLaRc9HcN3l/fC8YRBf+eDjwzJhGcYmNixD8o
         qfyQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of lkp@intel.com designates 134.134.136.126 as permitted sender) smtp.mailfrom=lkp@intel.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=intel.com
Return-Path: <lkp@intel.com>
Received: from mga18.intel.com (mga18.intel.com. [134.134.136.126])
        by mx.google.com with ESMTPS id i19si4117568pfd.176.2020.09.18.20.52.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Sep 2020 20:52:56 -0700 (PDT)
Received-SPF: pass (google.com: domain of lkp@intel.com designates 134.134.136.126 as permitted sender) client-ip=134.134.136.126;
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of lkp@intel.com designates 134.134.136.126 as permitted sender) smtp.mailfrom=lkp@intel.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=intel.com
IronPort-SDR: /Xol7AclNxIAOcfqKJWij3aIYzX5kiTMOXJGO163KnDM8Q1VX543mTg1Mo3eaLANpoGLqEDkO3
 cmJrFZLtkCxQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9748"; a="147829964"
X-IronPort-AV: E=Sophos;i="5.77,277,1596524400"; 
   d="gz'50?scan'50,208,50";a="147829964"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2020 20:52:52 -0700
IronPort-SDR: 0tDJH/CtIQ3O/oeC7VUXDcpyg4E3Qn6RMZt4AZ1ntJpix68SF7JkKAS5VnNLBjBomkCmaJ6EOw
 O/OsGPWcxATQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,277,1596524400"; 
   d="gz'50?scan'50,208,50";a="320862028"
Received: from lkp-server01.sh.intel.com (HELO a05db971c861) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 18 Sep 2020 20:52:48 -0700
Received: from kbuild by a05db971c861 with local (Exim 4.92)
	(envelope-from <lkp@intel.com>)
	id 1kJTvc-0000rC-1k; Sat, 19 Sep 2020 03:52:48 +0000
Date: Sat, 19 Sep 2020 11:52:28 +0800
From: kernel test robot <lkp@intel.com>
To: Bob Pearson <rpearsonhpe@gmail.com>, jgg@nvidia.com,
	zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc: kbuild-all@lists.01.org, clang-built-linux@googlegroups.com,
	Bob Pearson <rpearson@hpe.com>
Subject: Re: [PATCH for-next v5 06/12] rdma_rxe: Add memory access through MWs
Message-ID: <202009191108.vBrrZUCe%lkp@intel.com>
References: <20200918211517.5295-7-rpearson@hpe.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="UugvWAfsgieZRqgk"
Content-Disposition: inline
In-Reply-To: <20200918211517.5295-7-rpearson@hpe.com>
User-Agent: Mutt/1.10.1 (2018-07-13)


--UugvWAfsgieZRqgk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Bob,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on rdma/for-next]
[also build test WARNING on v5.9-rc5 next-20200918]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Bob-Pearson/rdma_rxe-API-extensions/20200919-051909
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-next
config: riscv-randconfig-r031-20200917 (attached as .config)
compiler: clang version 12.0.0 (https://github.com/llvm/llvm-project ed79827aea444e6995fb3d36abc2bfd36331773c)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=riscv 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from arch/riscv/include/asm/io.h:148:
   include/asm-generic/io.h:556:9: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           return inb(addr);
                  ^~~~~~~~~
   arch/riscv/include/asm/io.h:54:76: note: expanded from macro 'inb'
   #define inb(c)          ({ u8  __v; __io_pbr(); __v = readb_cpu((void*)(PCI_IOBASE + (c))); __io_par(__v); __v; })
                                                                           ~~~~~~~~~~ ^
   arch/riscv/include/asm/mmio.h:87:48: note: expanded from macro 'readb_cpu'
   #define readb_cpu(c)            ({ u8  __r = __raw_readb(c); __r; })
                                                            ^
   In file included from drivers/infiniband/sw/rxe/rxe_mr.c:7:
   In file included from drivers/infiniband/sw/rxe/rxe.h:16:
   In file included from include/linux/skbuff.h:31:
   In file included from include/linux/dma-mapping.h:11:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/riscv/include/asm/io.h:148:
   include/asm-generic/io.h:564:9: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           return inw(addr);
                  ^~~~~~~~~
   arch/riscv/include/asm/io.h:55:76: note: expanded from macro 'inw'
   #define inw(c)          ({ u16 __v; __io_pbr(); __v = readw_cpu((void*)(PCI_IOBASE + (c))); __io_par(__v); __v; })
                                                                           ~~~~~~~~~~ ^
   arch/riscv/include/asm/mmio.h:88:76: note: expanded from macro 'readw_cpu'
   #define readw_cpu(c)            ({ u16 __r = le16_to_cpu((__force __le16)__raw_readw(c)); __r; })
                                                                                        ^
   include/uapi/linux/byteorder/little_endian.h:36:51: note: expanded from macro '__le16_to_cpu'
   #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
                                                     ^
   In file included from drivers/infiniband/sw/rxe/rxe_mr.c:7:
   In file included from drivers/infiniband/sw/rxe/rxe.h:16:
   In file included from include/linux/skbuff.h:31:
   In file included from include/linux/dma-mapping.h:11:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/riscv/include/asm/io.h:148:
   include/asm-generic/io.h:572:9: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           return inl(addr);
                  ^~~~~~~~~
   arch/riscv/include/asm/io.h:56:76: note: expanded from macro 'inl'
   #define inl(c)          ({ u32 __v; __io_pbr(); __v = readl_cpu((void*)(PCI_IOBASE + (c))); __io_par(__v); __v; })
                                                                           ~~~~~~~~~~ ^
   arch/riscv/include/asm/mmio.h:89:76: note: expanded from macro 'readl_cpu'
   #define readl_cpu(c)            ({ u32 __r = le32_to_cpu((__force __le32)__raw_readl(c)); __r; })
                                                                                        ^
   include/uapi/linux/byteorder/little_endian.h:34:51: note: expanded from macro '__le32_to_cpu'
   #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
                                                     ^
   In file included from drivers/infiniband/sw/rxe/rxe_mr.c:7:
   In file included from drivers/infiniband/sw/rxe/rxe.h:16:
   In file included from include/linux/skbuff.h:31:
   In file included from include/linux/dma-mapping.h:11:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/riscv/include/asm/io.h:148:
   include/asm-generic/io.h:580:2: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           outb(value, addr);
           ^~~~~~~~~~~~~~~~~
   arch/riscv/include/asm/io.h:58:68: note: expanded from macro 'outb'
   #define outb(v,c)       ({ __io_pbw(); writeb_cpu((v),(void*)(PCI_IOBASE + (c))); __io_paw(); })
                                                                 ~~~~~~~~~~ ^
   arch/riscv/include/asm/mmio.h:91:52: note: expanded from macro 'writeb_cpu'
   #define writeb_cpu(v, c)        ((void)__raw_writeb((v), (c)))
                                                             ^
   In file included from drivers/infiniband/sw/rxe/rxe_mr.c:7:
   In file included from drivers/infiniband/sw/rxe/rxe.h:16:
   In file included from include/linux/skbuff.h:31:
   In file included from include/linux/dma-mapping.h:11:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/riscv/include/asm/io.h:148:
   include/asm-generic/io.h:588:2: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           outw(value, addr);
           ^~~~~~~~~~~~~~~~~
   arch/riscv/include/asm/io.h:59:68: note: expanded from macro 'outw'
   #define outw(v,c)       ({ __io_pbw(); writew_cpu((v),(void*)(PCI_IOBASE + (c))); __io_paw(); })
                                                                 ~~~~~~~~~~ ^
   arch/riscv/include/asm/mmio.h:92:76: note: expanded from macro 'writew_cpu'
   #define writew_cpu(v, c)        ((void)__raw_writew((__force u16)cpu_to_le16(v), (c)))
                                                                                     ^
   In file included from drivers/infiniband/sw/rxe/rxe_mr.c:7:
   In file included from drivers/infiniband/sw/rxe/rxe.h:16:
   In file included from include/linux/skbuff.h:31:
   In file included from include/linux/dma-mapping.h:11:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/riscv/include/asm/io.h:148:
   include/asm-generic/io.h:596:2: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           outl(value, addr);
           ^~~~~~~~~~~~~~~~~
   arch/riscv/include/asm/io.h:60:68: note: expanded from macro 'outl'
   #define outl(v,c)       ({ __io_pbw(); writel_cpu((v),(void*)(PCI_IOBASE + (c))); __io_paw(); })
                                                                 ~~~~~~~~~~ ^
   arch/riscv/include/asm/mmio.h:93:76: note: expanded from macro 'writel_cpu'
   #define writel_cpu(v, c)        ((void)__raw_writel((__force u32)cpu_to_le32(v), (c)))
                                                                                     ^
   In file included from drivers/infiniband/sw/rxe/rxe_mr.c:7:
   In file included from drivers/infiniband/sw/rxe/rxe.h:16:
   In file included from include/linux/skbuff.h:31:
   In file included from include/linux/dma-mapping.h:11:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/riscv/include/asm/io.h:148:
   include/asm-generic/io.h:1017:55: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           return (port > MMIO_UPPER_LIMIT) ? NULL : PCI_IOBASE + port;
                                                     ~~~~~~~~~~ ^
>> drivers/infiniband/sw/rxe/rxe_mr.c:531:5: warning: no previous prototype for function 'rxe_invalidate_mr' [-Wmissing-prototypes]
   int rxe_invalidate_mr(struct rxe_qp *qp, struct rxe_mr *mr)
       ^
   drivers/infiniband/sw/rxe/rxe_mr.c:531:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int rxe_invalidate_mr(struct rxe_qp *qp, struct rxe_mr *mr)
   ^
   static 
   8 warnings generated.

# https://github.com/0day-ci/linux/commit/ea6524464bcccdce769f9a046224290a51dee110
git remote add linux-review https://github.com/0day-ci/linux
git fetch --no-tags linux-review Bob-Pearson/rdma_rxe-API-extensions/20200919-051909
git checkout ea6524464bcccdce769f9a046224290a51dee110
vim +/rxe_invalidate_mr +531 drivers/infiniband/sw/rxe/rxe_mr.c

   530	
 > 531	int rxe_invalidate_mr(struct rxe_qp *qp, struct rxe_mr *mr)
   532	{
   533		mr->state = RXE_MEM_STATE_FREE;
   534		return 0;
   535	}
   536	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--UugvWAfsgieZRqgk
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--UugvWAfsgieZRqgk--

--------------D46A12E6EA390D9FC6AE94D0--
