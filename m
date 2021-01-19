Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B5112FAE3A
	for <lists+linux-rdma@lfdr.de>; Tue, 19 Jan 2021 02:05:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732840AbhASBFD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 18 Jan 2021 20:05:03 -0500
Received: from mail-1.ca.inter.net ([208.85.220.69]:46116 "EHLO
        mail-1.ca.inter.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732238AbhASBFD (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 18 Jan 2021 20:05:03 -0500
Received: from localhost (offload-3.ca.inter.net [208.85.220.70])
        by mail-1.ca.inter.net (Postfix) with ESMTP id 5895E2EA058;
        Mon, 18 Jan 2021 20:04:21 -0500 (EST)
Received: from mail-1.ca.inter.net ([208.85.220.69])
        by localhost (offload-3.ca.inter.net [208.85.220.70]) (amavisd-new, port 10024)
        with ESMTP id YDJ1pjI18RLg; Mon, 18 Jan 2021 19:50:44 -0500 (EST)
Received: from [192.168.48.23] (host-104-157-204-209.dyn.295.ca [104.157.204.209])
        (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: dgilbert@interlog.com)
        by mail-1.ca.inter.net (Postfix) with ESMTPSA id A39982EA02A;
        Mon, 18 Jan 2021 20:04:20 -0500 (EST)
Reply-To: dgilbert@interlog.com
Subject: Re: [PATCH v6 3/4] scatterlist: add sgl_compare_sgl() function
To:     David Disseldorp <ddiss@suse.de>
Cc:     linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        target-devel@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, martin.petersen@oracle.com,
        jejb@linux.vnet.ibm.com, bostroesser@gmail.com, bvanassche@acm.org,
        jgg@ziepe.ca
References: <20210118163006.61659-1-dgilbert@interlog.com>
 <20210118163006.61659-4-dgilbert@interlog.com>
 <20210119002741.4dbc290e@suse.de>
From:   Douglas Gilbert <dgilbert@interlog.com>
Message-ID: <d0b8312b-5dbf-6196-d962-40851c5cbbf7@interlog.com>
Date:   Mon, 18 Jan 2021 20:04:20 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210119002741.4dbc290e@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2021-01-18 6:27 p.m., David Disseldorp wrote:
> On Mon, 18 Jan 2021 11:30:05 -0500, Douglas Gilbert wrote:
> 
>> After enabling copies between scatter gather lists (sgl_s), another
>> storage related operation is to compare two sgl_s. This new function
>> is modelled on NVMe's Compare command and the SCSI VERIFY(BYTCHK=1)
>> command. Like memcmp() this function returns false on the first
>> miscompare and stops comparing.
>>
>> A helper function called sgl_compare_sgl_idx() is added. It takes an
>> additional parameter (miscompare_idx) which is a pointer. If that
>> pointer is non-NULL and a miscompare is detected (i.e. the function
>> returns false) then the byte index of the first miscompare is written
>> to *miscomapre_idx. Knowing the location of the first miscompare is
>> needed to implement the SCSI COMPARE AND WRITE command properly.
>>
>> Reviewed-by: Bodo Stroesser <bostroesser@gmail.com>
>> Signed-off-by: Douglas Gilbert <dgilbert@interlog.com>
>> ---
>>   include/linux/scatterlist.h |   8 +++
>>   lib/scatterlist.c           | 109 ++++++++++++++++++++++++++++++++++++
>>   2 files changed, 117 insertions(+)
>>
>> diff --git a/include/linux/scatterlist.h b/include/linux/scatterlist.h
>> index 3f836a3246aa..71be65f9ebb5 100644
>> --- a/include/linux/scatterlist.h
>> +++ b/include/linux/scatterlist.h
>> @@ -325,6 +325,14 @@ size_t sgl_copy_sgl(struct scatterlist *d_sgl, unsigned int d_nents, off_t d_ski
>>   		    struct scatterlist *s_sgl, unsigned int s_nents, off_t s_skip,
>>   		    size_t n_bytes);
>>   
>> +bool sgl_compare_sgl(struct scatterlist *x_sgl, unsigned int x_nents, off_t x_skip,
>> +		     struct scatterlist *y_sgl, unsigned int y_nents, off_t y_skip,
>> +		     size_t n_bytes);
>> +
>> +bool sgl_compare_sgl_idx(struct scatterlist *x_sgl, unsigned int x_nents, off_t x_skip,
>> +			 struct scatterlist *y_sgl, unsigned int y_nents, off_t y_skip,
>> +			 size_t n_bytes, size_t *miscompare_idx);
> 
> 
> This patch looks good and works fine as a replacement for
> compare_and_write_do_cmp(). One minor suggestion would be to name it
> sgl_equal() or similar, to perhaps better reflect the bool return and
> avoid memcmp() confusion. Either way:
> Reviewed-by: David Disseldorp <ddiss@suse.de>

Thanks. NVMe calls the command that does this Compare and SCSI uses
COMPARE AND WRITE (and VERIFY(BYTCHK=1) ) but "equal" is fine with me.
There will be another patchset version (at least) so there is time
to change.

Do you want:
   - sgl_equal(...), or
   - sgl_equal_sgl(...) ?

Doug Gilbert

