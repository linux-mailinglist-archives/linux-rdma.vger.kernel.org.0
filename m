Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6389433978
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Jun 2019 22:03:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbfFCUDH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 3 Jun 2019 16:03:07 -0400
Received: from mga18.intel.com ([134.134.136.126]:19456 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726097AbfFCUDH (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 3 Jun 2019 16:03:07 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Jun 2019 13:03:06 -0700
X-ExtLoop1: 1
Received: from ddalessa-mobl.amr.corp.intel.com (HELO [10.254.207.101]) ([10.254.207.101])
  by fmsmga008.fm.intel.com with ESMTP; 03 Jun 2019 13:03:05 -0700
Subject: Re: try_module_get in hfi1
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <20190603152000.GG11488@mellanox.com>
From:   Dennis Dalessandro <dennis.dalessandro@intel.com>
Message-ID: <d36c8c66-db74-c9e0-4ae8-bd51e0d476eb@intel.com>
Date:   Mon, 3 Jun 2019 16:03:04 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190603152000.GG11488@mellanox.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 6/3/2019 11:20 AM, Jason Gunthorpe wrote:
> Intel Guys,
> 
> I'm looking at code in hfi1:
> 
> static int __i2c_debugfs_open(struct inode *in, struct file *fp, u32 target)
> {
> 	struct hfi1_pportdata *ppd;
> 	int ret;
> 
> 	if (!try_module_get(THIS_MODULE))
> 		return -ENODEV;
> 
> Seems like nonsense to me.
> 
> I think it should be:
> 
> --- a/drivers/infiniband/hw/hfi1/debugfs.c
> +++ b/drivers/infiniband/hw/hfi1/debugfs.c
> @@ -1155,6 +1155,7 @@ static int exprom_wp_debugfs_release(struct inode *in, struct file *fp)
>   { \
>          .name = nm, \
>          .ops = { \
> +               .owner = THIS_MODULE, \
>                  .read = readroutine, \
>                  .write = writeroutine, \
>                  .llseek = generic_file_llseek, \
> @@ -1165,6 +1166,7 @@ static int exprom_wp_debugfs_release(struct inode *in, struct file *fp)
>   { \
>          .name = nm, \
>          .ops = { \
> +               .owner = THIS_MODULE, \
>                  .read = readf, \
>                  .write = writef, \
>                  .llseek = generic_file_llseek, \
> 
> 
> Can you fix it??
> 
> Jason
> 

Hmm. Yeah, let me take a look.

-Denny
