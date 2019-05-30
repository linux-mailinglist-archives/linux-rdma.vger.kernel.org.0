Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F34C2FC00
	for <lists+linux-rdma@lfdr.de>; Thu, 30 May 2019 15:11:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726079AbfE3NLU convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Thu, 30 May 2019 09:11:20 -0400
Received: from mga12.intel.com ([192.55.52.136]:61078 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726031AbfE3NLU (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 30 May 2019 09:11:20 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 May 2019 06:11:20 -0700
X-ExtLoop1: 1
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
  by orsmga001.jf.intel.com with ESMTP; 30 May 2019 06:11:19 -0700
Received: from fmsmsx113.amr.corp.intel.com (10.18.116.7) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Thu, 30 May 2019 06:11:19 -0700
Received: from crsmsx103.amr.corp.intel.com (172.18.63.31) by
 FMSMSX113.amr.corp.intel.com (10.18.116.7) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Thu, 30 May 2019 06:11:19 -0700
Received: from crsmsx101.amr.corp.intel.com ([169.254.1.108]) by
 CRSMSX103.amr.corp.intel.com ([169.254.4.125]) with mapi id 14.03.0415.000;
 Thu, 30 May 2019 07:11:17 -0600
From:   "Wan, Kaike" <kaike.wan@intel.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [bug report] IB/hfi1: Rework fault injection machinery
Thread-Topic: [bug report] IB/hfi1: Rework fault injection machinery
Thread-Index: AQHVFseQj4iXvj+GoUafcyXHwCEXWKaDpFog
Date:   Thu, 30 May 2019 13:11:17 +0000
Message-ID: <3F128C9216C9B84BB6ED23EF16290AFB75117469@CRSMSX101.amr.corp.intel.com>
References: <20190530091021.GA26681@mwanda>
In-Reply-To: <20190530091021.GA26681@mwanda>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNmY4N2IyOWYtZWM1Ni00MDBjLWJiMGYtMDI3N2NlMmI0YTdiIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiXC9QUkdRYk9TODQzeEhoNmVhK2dQeXZDeWZHazZlcHhTUWpOb0tpejhYOGQ2RUNGVnlaQVdPYUttVGFWeitJOGYifQ==
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.600.7
dlp-reaction: no-action
x-originating-ip: [172.18.205.10]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

We will fix it.

Thank you!

Kaike

> -----Original Message-----
> From: linux-rdma-owner@vger.kernel.org [mailto:linux-rdma-
> owner@vger.kernel.org] On Behalf Of Dan Carpenter
> Sent: Thursday, May 30, 2019 5:10 AM
> To: mitko.haralanov@intel.com
> Cc: linux-rdma@vger.kernel.org
> Subject: [bug report] IB/hfi1: Rework fault injection machinery
> 
> Hello Mitko Haralanov,
> 
> The patch a74d5307caba: "IB/hfi1: Rework fault injection machinery"
> from May 2, 2018, leads to the following static checker warning:
> 
> 	drivers/infiniband/hw/hfi1/fault.c:183 fault_opcodes_write()
> 	error: passing untrusted data 'i' to 'clear_bit()'
> 
> drivers/infiniband/hw/hfi1/fault.c
>    144          if (copy_from_user(data, buf, copy))
>    145                  return -EFAULT;
>    146
>    147          ret = debugfs_file_get(file->f_path.dentry);
>    148          if (unlikely(ret))
>    149                  return ret;
>    150          ptr = data;
>    151          token = ptr;
>    152          for (ptr = data; *ptr; ptr = end + 1, token = ptr) {
>    153                  char *dash;
>    154                  unsigned long range_start, range_end, i;
>    155                  bool remove = false;
>    156
>    157                  end = strchr(ptr, ',');
>    158                  if (end)
>    159                          *end = '\0';
>    160                  if (token[0] == '-') {
>    161                          remove = true;
>    162                          token++;
>    163                  }
>    164                  dash = strchr(token, '-');
>    165                  if (dash)
>    166                          *dash = '\0';
>    167                  if (kstrtoul(token, 0, &range_start))
>                                                ^^^^^^^^^^^^ Smatch marks this as untrusted
> 
>    168                          break;
>    169                  if (dash) {
>    170                          token = dash + 1;
>    171                          if (kstrtoul(token, 0, &range_end))
>                                                        ^^^^^^^^^^ and this also
> 
>    172                                  break;
>    173                  } else {
>    174                          range_end = range_start;
>    175                  }
>    176                  if (range_start == range_end && range_start == -1UL) {
>    177                          bitmap_zero(fault->opcodes, sizeof(fault->opcodes) *
>    178                                      BITS_PER_BYTE);
>    179                          break;
>    180                  }
>    181                  for (i = range_start; i <= range_end; i++) {
>    182                          if (remove)
>    183                                  clear_bit(i, fault->opcodes);
>                                                   ^
>    184                          else
>    185                                  set_bit(i, fault->opcodes);
>                                                 ^
> 
> Smatch complains that "i" can be beyond the end of bitmap.
> 
>    186                  }
>    187                  if (!end)
>    188                          break;
> 
> regards,
> dan carpenter
