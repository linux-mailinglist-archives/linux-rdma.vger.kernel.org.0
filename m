Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5743CFE68E
	for <lists+linux-rdma@lfdr.de>; Fri, 15 Nov 2019 21:46:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbfKOUqB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 15 Nov 2019 15:46:01 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:39848 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726766AbfKOUqB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 15 Nov 2019 15:46:01 -0500
Received: by mail-qv1-f67.google.com with SMTP id v16so4277867qvq.6
        for <linux-rdma@vger.kernel.org>; Fri, 15 Nov 2019 12:46:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9GJlCjI/Cv5x6PVbZp/gpGMYd/jaWVOUnhWCBgNIuU0=;
        b=RRsztBOyQh5+LdpJCsWLBFewhKX8rnNwdEnP5nZMVPucaTfV+kCDZiK3A6i/gpk8tD
         mwhIhb6zz3NbnuY4dX3X1DUcvAXg7BGbsLytK6Wg6Yzyd2VG5JYam52Ki02EZJwk+gqQ
         fwPf5f+MZ3sHQlw7dSM1fYErdeycLlUtft7uDAfywtF2Z80Xm9/cgez/mekTjj7aEB6b
         5lZCI2ItKHczWzdpVuHgJFw7tyGIypnnTO+uGP0TlozLq98SO2aGW87k+edPDC66v3Y+
         eZHuOtK7gj12BKAMlncogzzWWjJhAMXcd+8GT6xdogt2Ymn8NATEHDITJwjjsOuqkrJb
         jEOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9GJlCjI/Cv5x6PVbZp/gpGMYd/jaWVOUnhWCBgNIuU0=;
        b=F1AzioZRHiP8TFpcJ+YMNVh6QK5iqfKBJgfhIdU2vEdsVQYpIn4eaY9jVpyZbJKMD4
         HPbj0gZoksAh3Qusyun8RXLUhqsc3b0LnKoqxEHYM8EF1QPuFQ93zYA8xRHHSXzabk0Z
         q5bdjURJ11Ic6SvX4tdktkE/taFpSBU5lo4ii1PSeOAkx3ji3UMxkTKowlRBzzYIpn5Q
         J+Z5mIxybGNWViPtiFrPPjxJ9Mh4vQ7HaC9eHYuBXGC1AFo78uWmpvZQQAfyEaW950Tb
         ZJT1rQZx2Va+I4oligom7eN2ghM/eYlAE7cLGsv7AdmDB60SuftbzY/96QOf9j7ouERI
         In5w==
X-Gm-Message-State: APjAAAVVb+o9+suwFIPVvgTactbb0QTXl8jjWzVsiRuB/WyEPbKyAXz6
        8Mz2bEn7pQvx8lw6FDNglAkYqJLKNv4=
X-Google-Smtp-Source: APXvYqxEfCuky8ivHujh9vcJ5hm/Xq2tND8iOQyOq0FDs9Og6YtwmVqolg7oR7FqrBMWZXjULO1PWA==
X-Received: by 2002:a05:6214:907:: with SMTP id dj7mr15593280qvb.108.1573850759922;
        Fri, 15 Nov 2019 12:45:59 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id g25sm5539446qtc.90.2019.11.15.12.45.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Nov 2019 12:45:59 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iViTe-00006c-2T; Fri, 15 Nov 2019 16:45:58 -0400
Date:   Fri, 15 Nov 2019 16:45:58 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-next 01/43] RDMA/cm: Add naive SET/GET
 implementations to hide CM wire format
Message-ID: <20191115204558.GA22185@ziepe.ca>
References: <20191027070621.11711-1-leon@kernel.org>
 <20191027070621.11711-2-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191027070621.11711-2-leon@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Oct 27, 2019 at 09:05:39AM +0200, Leon Romanovsky wrote:

>  #define IB_CM_CLASS_VERSION	2 /* IB specification 1.2 */
> +#define _CM_SET(p, offset, mask, value)                                        \
> +	({                                                                     \
> +		void *field = (u8 *)p + sizeof(struct ib_mad_hdr) + offset;    \
> +		u8 bytes =                                                     \
> +			DIV_ROUND_UP(__builtin_popcount(mask), BITS_PER_BYTE); \
> +		switch (bytes) {                                               \
> +		case 1: {                                                      \
> +			*(u8 *)field &= ~mask;                                 \
> +			*(u8 *)field |= FIELD_PREP(mask, value);               \
> +		} break;                                                       \
> +		case 2: {                                                      \
> +			u16 val = ntohs(*(__be16 *)field) & ~mask;             \
> +			val |= FIELD_PREP(mask, value);                        \
> +			*(__be16 *)field = htons(val);                         \
> +		} break;                                                       \
> +		case 3: {                                                      \
> +			u32 val = ntohl(*(__be32 *)field) & ~(mask << 8);      \
> +			val |= FIELD_PREP(mask, value) << 8;                   \
> +			*(__be32 *)field = htonl(val);                         \

This doesn't work for flow label which has a 20 byte field, the <<8 is
just a hack to fix the 24 byte case.

This is also some typo's:

> + #define CM_REQ_LOCAL_EECN_OFFSET 36
> + #define CM_REQ_LOCAL_EECN_MASK GENMASK(24, 0)

Should be 23, 0

> + #define CM_REQ_PRIMARY_PACKET_RATE_OFFSET 91
> + #define CM_REQ_PRIMARY_PACKET_RATE_MASK GENMASK(3, 2)

Packet rate is a 6 bit field, not a 2 bit field

I only looked at REQ. I assume all the others have a similar error
rate.

Overall, I don't like this approach. The macros are messy/buggy and
there isn't a clear mapping of the data in the tables to the C code.

How about this instead:

static inline u32 _cm_get8(const u8 *ptr)
{
	return *ptr;
}

static inline void _cm_set8(u8 *ptr, u32 mask, u32 prep_value)
{
	*ptr = (*ptr & ~mask) | prep_value;
}

static inline u16 _cm_get16(const __be16 *ptr)
{
	return be16_to_cpu(*ptr);
}

static inline void _cm_set16(__be16 *ptr, u16 mask, u16 prep_value)
{
	*ptr = cpu_to_be16((be16_to_cpu(*ptr) & ~mask) | prep_value);
}

static inline u32 _cm_get32(const __be32 *ptr)
{
	return be32_to_cpu(*ptr);
}

static inline void _cm_set32(__be32 *ptr, u32 mask, u32 prep_value)
{
	*ptr = cpu_to_be32((be32_to_cpu(*ptr) & ~mask) | prep_value);
}

static inline u64 _cm_get64(const __be64 *ptr)
{
	/*
	 * The mads are constructed so that 32 bit and smaller are naturally
	 * aligned, everything larger has a max alignment of 4 bytes.
	 */
	return be64_to_cpu(get_unaligned(ptr));
}

static inline void _cm_set64(__be64 *ptr, u64 mask, u64 prep_value)
{
	put_unaligned(cpu_to_be64((_cm_get64(ptr) & ~mask) | prep_value), ptr);
}

#define _CM_SET(field_struct, field_offset, field_mask, mask_width, ptr,       \
		value)                                                         \
	({                                                                     \
		field_struct *_ptr = ptr;                                      \
		_cm_set##mask_width((void *)_ptr + (field_offset), field_mask, \
				    FIELD_PREP(field_mask, value));            \
	})
#define CM_SET(field, ptr, value) _CM_SET(field, ptr, value)

#define _CM_SET_GID(field, ptr, val)                                           \
	({                                                                     \
		field_struct *_ptr = ptr;                                      \
		const union ib_gid *_val = val;                                \
		memcpy((void *)_ptr + field_offset, _val, sizeof(*_out));      \
	})
#define CM_SET_GID(field, ptr, val) _CM_SET_GID(field, ptr, val)

#define _CM_GET(field_struct, field_offset, field_mask, mask_width, ptr)       \
	({                                                                     \
		const field_struct *_ptr = ptr;                                \
		(u##mask_width) FIELD_GET(                                     \
			field_mask, _cm_get##mask_width((const void *)_ptr +   \
							(field_offset)));      \
	})
#define CM_GET(field, ptr) _CM_GET(field, ptr)

#define _CM_GET_GID(field_struct, field_offset, ptr, out)                      \
	({                                                                     \
		const field_struct *_ptr = ptr;                                \
		union ib_gid *_out = out;                                      \
		memcpy(_out, (void *)_ptr + field_offset, sizeof(*_out));      \
	})
#define CM_GET_GID(field, ptr, out) _CM_GET_GID(field, ptr, out)

/*
 * The generated list becomes the parameters to the macros, the order is:
 *  - struct this applies to
 *  - starting offset of the max
 *  - GENMASK or GENMASK_ULL in CPU order
 *  - The width of data the mask operations should work on, in bits
 */

/*
 * Extraction using a tabular description like table 106. bit_offset is from
 * the Byte[Bit] notation.
 */
#define IBA_FIELD_BLOC(field_struct, byte_offset, bit_offset, num_bits)        \
	field_struct, byte_offset,                                             \
		GENMASK(7 - (bit_offset), 7 - (bit_offset) - (num_bits - 1)),  \
		8
#define IBA_FIELD8_LOC(field_struct, byte_offset, num_bits)                    \
	IBA_FIELD_BLOC(field_struct, byte_offset, 0, num_bits)

#define IBA_FIELD16_LOC(field_struct, byte_offset, num_bits)                   \
	field_struct, (byte_offset)&0xFFFE,                                    \
		GENMASK(15 - (((byte_offset) % 2) * 8),                        \
			15 - (((byte_offset) % 2) * 8) - (num_bits - 1)),      \
		16

#define IBA_FIELD32_LOC(field_struct, byte_offset, num_bits)                   \
	field_struct, (byte_offset)&0xFFFC,                                    \
		GENMASK(31 - (((byte_offset) % 4) * 8),                        \
			31 - (((byte_offset) % 4) * 8) - (num_bits - 1)),      \
		32

#define IBA_FIELD64_LOC(field_struct, byte_offset, num_bits)                   \
	field_struct, (byte_offset)&0xFFF8,                                    \
		GENMASK_ULL(63 - (((byte_offset) % 8) * 8),                    \
			    63 - (((byte_offset) % 8) * 8) - (num_bits - 1)),  \
		64

#define IBA_FIELD_GID_LOC(field_struct, byte_offset) field_struct, byte_offset

/* From Table 106 */
#define CM_REQ_LOCAL_COMM_ID IBA_FIELD32_LOC(struct cm_req_msg, 0, 32)
#define CM_REQ_SERVICE_ID IBA_FIELD64_LOC(struct cm_req_msg, 8, 64)
#define CM_REQ_LOCAL_CA_GUID IBA_FIELD64_LOC(struct cm_req_msg, 16, 64)
#define CM_REQ_LOCAL_Q_KEY IBA_FIELD32_LOC(struct cm_req_msg, 28, 32)
#define CM_REQ_LOCAL_QPN IBA_FIELD32_LOC(struct cm_req_msg, 32, 24)
#define CM_REQ_RESPONDED_RESOURCES IBA_FIELD8_LOC(struct cm_req_msg, 35, 8)
#define CM_REQ_LOCAL_EECN IBA_FIELD32_LOC(struct cm_req_msg, 36, 24)
#define CM_REQ_INITIATOR_DEPTH IBA_FIELD8_LOC(struct cm_req_msg, 39, 8)
#define CM_REQ_REMOTE_EECN IBA_FIELD32_LOC(struct cm_req_msg, 40, 24)
#define CM_REQ_REMOTE_CM_RESPONSE_TIMEOUT IBA_FIELD8_LOC(struct cm_req_msg, 43, 5)
#define CM_REQ_TRANSPORT_SERVICE_TYPE IBA_FIELD_BLOC(struct cm_req_msg, 43, 5, 2)
#define CM_REQ_END_TO_END_FLOW_CONTROL IBA_FIELD_BLOC(struct cm_req_msg, 43, 7, 1)
#define CM_REQ_STARTING_PSN IBA_FIELD32_LOC(struct cm_req_msg, 44, 24)
#define CM_REQ_LOCAL_CM_RESPONSE_TIMEOUT IBA_FIELD8_LOC(struct cm_req_msg, 47, 5)
#define CM_REQ_RETRY_COUNT IBA_FIELD_BLOC(struct cm_req_msg, 47, 5, 3)
#define CM_REQ_PARTITION_KEY IBA_FIELD16_LOC(struct cm_req_msg, 48, 16)
#define CM_REQ_PATH_PACKET_PAYLOAD_MTU IBA_FIELD8_LOC(struct cm_req_msg, 50, 4)
#define CM_REQ_RDC_EXISTS IBA_FIELD_BLOC(struct cm_req_msg, 50, 4, 1)
#define CM_REQ_RNR_RETRY_COUNT IBA_FIELD_BLOC(struct cm_req_msg, 50, 5, 3)
#define CM_REQ_MAX_CM_RETRIES IBA_FIELD8_LOC(struct cm_req_msg, 51, 4)
#define CM_REQ_SRQ IBA_FIELD_BLOC(struct cm_req_msg, 51, 4, 1)
#define CM_REQ_EXTENDED_TRANSPORT_TYPE IBA_FIELD_BLOC(struct cm_req_msg, 51, 5, 3)
#define CM_REQ_PRIMARY_LOCAL_PORT_LID IBA_FIELD16_LOC(struct cm_req_msg, 52, 16)
#define CM_REQ_PRIMARY_REMOTE_PORT_LID IBA_FIELD16_LOC(struct cm_req_msg, 54, 16)
#define CM_REQ_PRIMARY_LOCAL_PORT_GID IBA_FIELD_GID_LOC(struct cm_req_msg, 56)
#define CM_REQ_PRIMARY_REMOTE_PORT_GID IBA_FIELD_GID_LOC(struct cm_req_msg, 72)
#define CM_REQ_PRIMARY_FLOW_LABEL IBA_FIELD32_LOC(struct cm_req_msg, 88, 20)
#define CM_REQ_PRIMARY_PACKET_RATE IBA_FIELD_BLOC(struct cm_req_msg, 91, 2, 6)
#define CM_REQ_PRIMARY_TRAFFIC_CLASS IBA_FIELD8_LOC(struct cm_req_msg, 92, 8)
#define CM_REQ_PRIMARY_HOP_LIMIT IBA_FIELD8_LOC(struct cm_req_msg, 93, 8)
#define CM_REQ_PRIMARY_SL IBA_FIELD8_LOC(struct cm_req_msg, 94, 4)
#define CM_REQ_PRIMARY_SUBNET_LOCAL IBA_FIELD_BLOC(struct cm_req_msg, 94, 4, 1)
#define CM_REQ_PRIMARY_LOCAL_ACK_TIMEOUT IBA_FIELD8_LOC(struct cm_req_msg, 95, 5)
#define CM_REQ_ALTERNATE_LOCAL_PORT_LID IBA_FIELD16_LOC(struct cm_req_msg, 96, 16)
#define CM_REQ_ALTERNATE_REMOTE_PORT_LID IBA_FIELD16_LOC(struct cm_req_msg, 98, 16)
#define CM_REQ_ALTERNATE_LOCAL_PORT_GID IBA_FIELD_GID_LOC(struct cm_req_msg, 100)
#define CM_REQ_ALTERNATE_REMOTE_PORT_GID IBA_FIELD_GID_LOC(struct cm_req_msg, 116)
#define CM_REQ_ALTERNATE_FLOW_LABEL IBA_FIELD32_LOC(struct cm_req_msg, 132, 20)
#define CM_REQ_ALTERNATE_PACKET_RATE IBA_FIELD_BLOC(struct cm_req_msg, 135, 2, 6)
#define CM_REQ_ALTERNATE_TRAFFIC_CLASS IBA_FIELD8_LOC(struct cm_req_msg, 136, 8)
#define CM_REQ_ALTERNATE_HOP_LIMIT IBA_FIELD8_LOC(struct cm_req_msg, 137, 8)
#define CM_REQ_ALTERNATE_SL IBA_FIELD8_LOC(struct cm_req_msg, 138, 4)
#define CM_REQ_ALTERNATE_SUBNET_LOCAL IBA_FIELD_BLOC(struct cm_req_msg, 138, 4, 1)
#define CM_REQ_ALTERNATE_LOCAL_ACK_TIMEOUT IBA_FIELD8_LOC(struct cm_req_msg, 139, 5)
#define CM_REQ_SAP_SUPPORTED IBA_FIELD_BLOC(struct cm_req_msg, 139, 5, 1)
